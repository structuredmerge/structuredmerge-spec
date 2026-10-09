# Slice 1038: Platform Support Matrix Proposal

## Status and scope

This slice proposes first-class OS-platform support for the CI matrix, as a new
configuration feature spanning two gems:

- `kettle-rb` — owns the platform evidence data (source of truth);
- `kettle-jem` — owns the config key, repo-evidence detection, generation of the
  workflow OS matrix from facts, and README tier-table generation.

It exists because the platform column of `kettle-jem/RRRRrb-Matrix.md` was never
replicated into `Kettle::Rb::CompatMatrix`, and because destinations currently
have no way to declare which OS platforms they support.

Status: **proposal, design in progress.** The config contract and detection
heuristic below are decided. The platform vocabulary and per-version evidence are
PENDING research and must not be invented; see "Open items".

## Evidence for the gap

Verified against source at time of writing:

1. `RRRRrb-Matrix.md` has 8 columns. `Kettle::Rb::CompatMatrix::Entry` has 16
   fields covering 7 of them (plus `engine`, `workflow_ruby`, and rubocop-lts
   extras). No field maps to the `ARM64&<br/>MacOS 12` column. It is the only
   doc column without a library counterpart.
2. That column is binary across all 24 rows: `🙅` for MRI 1.8.7 through 2.5.9
   (8 rows); `🌱` for MRI 2.6.10+ and every JRuby and TruffleRuby row (16 rows).
3. Its heading conflates two unrelated things. GitHub's `macos-12` runners were
   Intel x86_64, so "ARM64 & MacOS 12" merges local Apple Silicon experience
   with a CI runner that was never ARM64. This is why the column is weakly
   evidenced, and why it must be rebuilt rather than copied.
4. No OS-platform config key exists anywhere in `kettle-jem`. Verified: no
   `platforms`/`oses`/`ci_platforms` key in the packaged config example, no such
   key in a destination config, no `KJ_` ENV override, and no code path that
   prunes an OS matrix. The only OS-matrix pruning that exists is by Ruby
   version: `prune_github_workflow_matrix_by_min_ruby` (`jem.rb:8957`) driven by
   `prune_workflow_matrix_item?` (`jem.rb:9108`).

## Generation, not pruning

An earlier draft of this slice specified pruning OS entries from the workflow
matrix. That was wrong and is retracted: `current.yml` is configured
`strategy: accept_template`, so it is replaced wholesale rather than merged.
There is no destination matrix to prune. The platform aspect of the workflow is
generated from facts and copied wholesale.

The precedent already exists in `kettle-jem`:
`github_actions_push_branches_yaml` (`jem.rb:20026`) builds a YAML block from
facts and splices it into three generated workflows (`jem.rb:19727`, `19793`,
`19939`). A platform-derived OS matrix is the same shape. Per-profile workflow
variants are also established practice, via
`shim/.github/workflows/current.yml.example` (`jem.rb:291`).

The actual defect is that `current.yml.example` is statically token-substituted
and never code-generated: the OS entries are literal `os: ubuntu-latest`,
`os: macos-latest`, and `os: windows-latest` at lines 42, 48, and 54. The
platform set is therefore hardcoded in the template, which is why no destination
can change it.

Only `current.yml` carries an OS matrix. Every other packaged workflow is
Linux-only by construction: the three generated workflows (`jem.rb:19743`,
`19809`, `19955`) hardcode `runs-on: ubuntu-latest`, and all versioned engine
workflows are Linux-only.

### Scope of what must be generated

Windows is not only a matrix entry. Dropping it must also handle:

- `if: matrix.os != 'windows-latest'` (`current.yml.example:99`), which becomes
  tautological and should be omitted rather than emitted always-true;
- the Windows-only step at lines 102-106, omitted entirely;
- cache keys interpolating `${{matrix.os}}` (lines 93-96), which stay correct
  unchanged.

Separate latent defect, in scope to fix as a side effect: line 106 hardcodes
`run: ruby -rbundler/setup bin/turbo_tests2` in the packaged template. That is
correct for `turbo_tests2` and wrong for any other destination that enables
Windows. Generating from facts should emit the destination's own executable.

Consequence: this feature does **not** require nested-owner YAML editing, and
therefore does not require the `psych-merge` nested layout work described below.

## Config contract (DECIDED)

Mirrors the existing `engines:` key exactly, since that is the established shape
for "which variants of a thing does this destination support":

```yaml
# OS platforms this project's CI exercises.
# Supported values: linux, macos, windows
# Default (when key is absent): linux, macos
platforms:
  - linux
  - macos
```

- `DEFAULT_PLATFORMS = %w[linux macos].freeze`, mirroring
  `DEFAULT_ENGINES = %w[ruby jruby truffleruby].freeze` (`jem.rb:94`).
- **Windows is opt-in only.** It is excluded from the default because Windows CI
  is materially slower and most gems do not need it; a destination that wants it
  must declare it.
- Read accessor mirrors `ruby_engines_config` (`jem.rb:13696`) and
  `enabled_ruby_engines` (`jem.rb:19071`), including the "absent or empty means
  default" semantics.
- Values are the canonical OS-platform vocabulary, PENDING confirmation against
  RubyGems/Bundler platform identifiers so the same tokens can serve config,
  matrix data, and workflow generation without a translation table.

## Bootstrap detection (DECIDED)

When this key is injected into a pre-existing config, its value must be computed
from repo evidence rather than defaulted, so re-templating a repo that already
runs Windows CI does not silently drop that coverage.

Pattern to follow is the licenses bootstrap: `detected_license_ids(project_root)`
(`jem.rb:5133`) gathers evidence from the repo, and config wins when present
(`jem.rb:2793-2794`).

Detection heuristic: grep the destination's `.github/workflows/*.yml` for the
canonical Windows `runs-on` tokens, then build the initial value accordingly.

The token set is verified narrow. Across all packaged workflow templates the only
Windows token is `windows-latest` (4 occurrences, all in `current.yml.example`),
and `runs-on:` only ever appears as `${{ matrix.os }}`, `ubuntu-22.04`, or
`ubuntu-latest`. Validated that the heuristic discriminates on real repos: of 60
scanned workspace workflow directories, 35 contain Windows tokens and 25 do not,
so it is not a constant.

Detection must also recognise the `matrix.os` indirection, since the OS lives in
the matrix `include:` list rather than in `runs-on:`.

### Sequence insertion already exists, and has a live defect

An earlier draft of this slice claimed no helper exists for inserting a YAML
block sequence. That was wrong and is retracted.
`ensure_yaml_top_level_sequence_items` (`jem.rb:12946`) already appends a missing
top-level key with block items and adds missing items to an existing sequence. It
is used today for `plugins:` (`jem.rb:6888`).

The helper is still not usable as-is, because it corrupts inline flow sequences.
Verified by extracting and running the method:

```
input:  engines:
          - ruby
        platforms: [linux]

output: engines:
          - ruby
        platforms: [linux]
        - macos          <- Psych::SyntaxError: did not find expected key

result: "did not find expected key while parsing a block"
```

It inserts block-style items after a flow-style sequence. The
`rescue Psych::Exception` does not catch it, because the corruption occurs on
write rather than on parse. This is reachable independently of the platform
feature: any destination with an inline `plugins: [...]` or `engines: [...]`
list gets an unparseable config on the next re-template. It should be recorded as
a known defect and fixed regardless of how the platform work proceeds.

A second limitation for this feature: when the key is absent it appends at end of
file (`jem.rb:12956-12959`) and emits no documentation comment. The packaged
config documents every key with a preceding comment block, so an injected
`platforms:` must carry its own documentation and land adjacent to `engines:`,
which it documents by analogy. `migrate_readme_logo_config`
(`jem.rb:12741-12772`) is the precedent for that read/migrate/insert control
flow.

### Adapter scoping

These two limitations are the concrete consumer for `ast-crispr-yaml-psych`, not
workflow matrix pruning. The adapter is justified by documented-sequence
insertion into existing config plus migrating the other config-editing methods
off the bespoke YAML stack in `jem.rb`, whose scale is the real argument:

- 38 methods matching `/yaml/i`;
- 25 `gsub(/\n{3,}/, "\n\n")` blank-line collapse workarounds;
- 81 line-index surgery sites (`lines.insert`, `lines[i] =`, `remove_indexes`);
- 8 raw `Psych::` call sites.

The 25 blank-line collapses are the same defect class centralized in
`Ast::Merge::StructuralEdit::BlankLineSupport`, scattered across call sites and
collapsing after the fact instead of respecting ownership.
`Ast::Merge::Layout::Gap#effective_controller` (`layout/gap.rb:130`) already
provides the machinery they substitute for.

Scope boundary: structural editing only. Some of the 38 methods are genuinely
`kettle-jem` policy rather than YAML editing and should stay — `build_yaml_block`
for checksums, `coverage_thresholds_from_yaml_workflow`, and
`assert_no_unresolved_template_tokens_in_yaml_values`. Migrating those would make
this a far larger change than the platform feature justifies.

The adapter is therefore independently motivated but **not a prerequisite** for
shipping the platform feature, since generation from facts requires no YAML
editing at all.

## Data model (kettle-rb, PENDING vocabulary)

Mirror `Kettle::Rb::GemFloors`, which already solves this problem class —
externally-sourced facts that must stay current and provable:

```
lib/kettle/rb/platform_support/data.rb       generated; "do not edit by hand"
lib/kettle/rb/platform_support/generator.rb  provenance + fetchers
rakelib/platform_support.rake                rake kettle:rb:platform_support:generate
```

`GemFloors` conventions to replicate:

- generated data file with a "do not edit by hand" header naming its sources;
- provenance constants: `GENERATED_ON`, plus a source-revision constant such as
  `ADVISORY_DB_COMMIT` (`gem_floors/data.rb:9-10`);
- injectable fetchers (`:versions_fetcher`, `:advisories_fetcher`) so specs never
  hit the network;
- a rake task to regenerate.

Each platform-support claim must carry a citation. That is the structural fix for
the weak-evidence problem: an unevidenced `🌱` becomes impossible to express,
rather than merely discouraged.

## Public API consequence

`kettle-rb/CHANGELOG.md` states that "platform and engine support are part of the
public API". This feature therefore changes a published contract and needs normal
changelog entries and a version bump in both gems, not just an internal change.

## README tier table

The stale destination table that motivated this work is the
`| Ruby engine/version | Linux | macOS | Windows | Notes |` table in
`turbo_tests2/README.md`. It is prose, not token output: no registered `KJ|`
token emits it, `compatibility_row?` (`jem.rb:1144`) matches only
`| Works with MRI Ruby|JRuby|Truffle Ruby` badge rows so no post-processor owns
it, and `git log -S 'Parallel support' --all` attributes it to a single prose
commit (`fd662da`), never a template commit.

It becomes a generated token derived from the same platform-support data, so it
cannot drift from CI again. The adjacent badge row IS already template-managed
and updated correctly on re-template.

## Open items (PENDING research, must not be invented)

1. Canonical OS-platform vocabulary — RubyGems `Gem::Platform` strings
   (`arm64-darwin`, `aarch64-linux`, `x64-mingw-ucrt`, …) versus Bundler
   `platforms:` DSL symbols versus GitHub runner labels, and whether an
   authoritative mapping exists.
2. GitHub runner labels and architecture per label, with deprecation dates —
   specifically which label was actually ARM64, and when `macos-latest`
   transitioned from Intel to ARM64.
3. Per-version MRI evidence: which versions have prebuilt `arm64-darwin`
   binaries, which have Windows installers, official EOL windows.
4. JRuby and TruffleRuby per-version platform support, including Linux ARM64 and
   TruffleRuby's known CI constraints.

## Acceptance criteria

1. `platforms:` is a documented config key with `DEFAULT_PLATFORMS = linux, macos`;
   Windows applies only when declared.
2. Re-templating a repo with existing Windows CI jobs detects and preserves
   `windows` in the injected value.
3. `current.yml` is generated with an OS matrix matching the declared platforms,
   and the Windows-only `if: matrix.os` guards and step are emitted only when
   Windows is declared, so no tautological condition survives.
4. The generated Windows step invokes the destination's own executable rather than
   a hardcoded `bin/turbo_tests2`.
5. Platform evidence lives in generated `kettle-rb` data with per-claim
   provenance; no hand-edited matrix.
6. The README tier table is generated from the same data and matches the generated
   workflows.
7. Specs cover matrix generation without network access, using the injectable
   fetcher pattern.
8. The `ensure_yaml_top_level_sequence_items` inline-flow-sequence corruption is
   fixed or recorded as a known defect with a reproduction.
