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

Status: **implemented** (2026-10-10). kettle-rb evidence layer:
kettle-dev/kettle-rb `91df9c5` (+ version bump `0b68d7a` preparing 0.1.17;
release pending). kettle-jem feature: structuredmerge/structuredmerge-ruby
`12fbd478e` (gemspec floor `kettle-rb >= 0.1.17`, so kettle-jem CI stays red
against released gems until kettle-rb 0.1.17 ships). Evidence is in
`slice-1038-platform-support-evidence.md`. Three findings from implementation
are recorded under "Implementation findings" below; none changes a DECIDED
item.

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

### Tracking

Both findings are tracked as issues in `structuredmerge-ruby` so the evidence
and the intended fix are not lost when this work is punted. These are cross-repo
references from this `structuredmerge-spec` document:

- structuredmerge/structuredmerge-ruby#73 (bug) —
  `ensure_yaml_top_level_sequence_items` corrupts flow sequences into unparseable
  YAML; reachable today via the live `plugins:` caller. Carries the verbatim
  five-case reproduction.
- structuredmerge/structuredmerge-ruby#74 (enhancement) — build
  `ast-crispr-yaml-psych` with nested-owner support and layout ownership,
  retiring the bespoke YAML stack. Carries the measured scale of that stack and
  the nested-layout gap evidence.

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

## Open items — RESOLVED by research

The platform vocabulary and per-version evidence were pending research. That
research is complete and is recorded in full, with citations, in
`slice-1038-platform-support-evidence.md`. The findings that constrain this
design:

1. **There are three existing platform vocabularies, and ours is a fourth.**
   Gemfile DSL `platforms:` symbols (`mri`, `jruby`, `windows`, ...) select a
   *Ruby implementation*; `Gem::Platform` strings (`x86_64-linux`,
   `arm64-darwin`, ...) select an *OS/architecture*; GitHub runner labels
   (`ubuntu-24.04-arm`, `macos-15-intel`) select *CI hardware*. The gemfile(5)
   man page explicitly warns the first two must not be conflated, and
   `linux`/`macos`/`windows` are **not valid** Gemfile DSL symbols — `Bundler::DSL`
   raises for them. Our `platforms:` config key names a fourth thing: CI OS
   families. That is defensible, since it selects runner labels rather than gem
   platforms, but it must ship an explicit mapping to runner labels and must
   never be passed to `bundle lock --add-platform` or a Gemfile DSL without
   translation.
2. **No authoritative runner-label → `Gem::Platform` mapping exists.** The correct
   programmatic approach is to run `ruby -e 'puts Gem::Platform.local'` on each
   runner rather than hardcode a table. Any derived mapping in the generated
   matrix must be labelled as convention, not fact.
3. **The old matrix column was wrong in a verifiable way.** `macos-12` was never
   ARM64 — no `macos-12-arm64` image ever existed, and ARM64 XL labels existed
   only for macOS 13. So "ARM64 & MacOS 12" named a combination that never
   occurred. `macos-latest` became ARM64 during the April–May 2024 macOS 14
   migration. This confirms the weak-evidence characterization precisely rather
   than merely restating it.
4. **Linux ARM64 CI is free for public repos** (`ubuntu-22.04-arm`,
   `ubuntu-24.04-arm`, `ubuntu-26.04-arm`; GA 2025-08-07, private repos from
   2026-01-29). The old matrix had no way to express this at all, so it is new
   capability rather than corrected data.
5. **`macos-latest` is floating and therefore not reproducible** — it silently
   changed both OS version and CPU architecture on GitHub's schedule. A generated
   matrix should record which label it used and on what date, so a support claim
   stays interpretable later. Pinning avoids drift but rots: `macos-14` retires
   2026-11-02 with brownouts through October 2026.
6. **TruffleRuby has never shipped a Windows build** (zero Windows assets across
   all 66 releases; `setup-ruby` hard-fails). The destination tier table's
   "Unsupported" for TruffleRuby/Windows can now be evidenced rather than
   asserted, and `windows` must be excluded from TruffleRuby lanes by
   construction rather than by convention.
7. **Do not prune the `ruby` platform when TruffleRuby is enabled.** TruffleRuby
   forces `Gem.platforms = [Gem::Platform::RUBY]` and Bundler unconditionally adds
   it, so a matrix that includes TruffleRuby must retain the pure-Ruby variant.
8. **RubyGems 4.1 introduces content-addressable (Ruby-ABI-specific) gems** named
   by SHA-256 prefix instead of platform. A matrix keyed purely on
   `name-version-platform.gem` strings will need to account for these, so the data
   model should not hardcode that filename shape.

## Fleet exposure (verified 2026-10-09)

No kettle-jem-templated Ruby gem pins `macos-14`, so the retirement on
2026-11-02 and its October brownouts do not affect this fleet. The packaged
template uses the floating `macos-latest` label
(`current.yml.example:48`), and `grep -rl 'macos-14' lib/` in kettle-jem returns
nothing. A workspace-wide scan excluding `vendor/`, `tmp/`, `.git/`, and
`bundler/gems` found only two files pinning it:
`structuredmerge/structuredmerge/.github/workflows/{current,publish}.yml`, whose
workflows are generated by the third-party Alef tool and are out of scope here.

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
   fixed or recorded as a known defect with a reproduction. Tracked as
   structuredmerge/structuredmerge-ruby#73.

## Implementation findings (2026-10-10)

Recorded so the reasoning survives; neither changes a DECIDED item above.

1. **The Windows step's command derives from `ci.exec_cmd`, not gemspec
   executables.** The proposal's "destination's own executable" reads most
   truthfully as the destination's own configured *test command*, resolved to
   its binstub: turbo_tests2 (the destination whose hardcoded `bin/turbo_tests2`
   motivated the fix) configures `exec_cmd: kettle-test`, so even there the
   hardcode was inconsistent with the destination's own config. Deriving from
   exec_cmd (`github_actions_windows_exec_binstub`) is correct for every
   destination including the dogfood case, and it avoids Kernel-loading the
   gemspec during facts discovery — a mid-bootstrap gemspec whose version file
   does not exist yet cannot be loaded, which an executables-from-gemspec
   implementation hit immediately (`Gem::Specification.load` LoadError in
   `gemspec_template_spec.rb`'s modern-version-loader fixture).

2. **The tier-table token's placement is constrained by section ownership.**
   The monorepo-subgem thin README projection
   (`apply_monorepo_subgem_thin_readme_projection`) deletes heading sections not
   in its keep-list. An early draft placed `### Runtime and Platform Support`
   inside the Compatibility section's span, which made the family-intro and
   dev-test-stack content part of the new removable section's span and deleted
   them with it (caught by `readme_changelog_template_spec.rb`'s badge-policy
   spec). The section now sits after `KJ|README:FAMILY_INTRO_BACKEND_MATRIX`,
   so its span contains only itself. Consequence: subgem READMEs intentionally
   do not carry the tier table — the thin projection exists to avoid
   per-subgem CI claims, and the table is a CI claim.

3. **Config injection does not use `ensure_yaml_top_level_sequence_items`.**
   The new `insert_yaml_block_after_top_level_key` locates the `engines:`
   anchor through the Psych AST (column-zero keys only, so a nested `engines:`
   under `files:` cannot become the anchor) and never touches a present
   `platforms:` key, which keeps the #73 flow-sequence corruption class out of
   this path entirely rather than depending on a fix for it.
