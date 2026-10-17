# Slice 1043: File-Type Detection and Merge Dispatch Contract

Part of slice-1040 (ast-template extraction). Third extracted contract surface:
**file-type detection** (what format is this destination path) and **merge
dispatch** (which merger handles it, with what arguments).

Status: **implemented** (2026-10-17). Detection + dispatch live in ast-template (`Ast::Template::FileTypes`, `Ast::Template::MergeDispatch`); kettle-jem delegates (`template_file_type`, and the yaml/toml/markdown merge branches). Conformance specs: `structuredmerge/ruby/gems/ast-template/spec/ast/template/merge_dispatch_spec.rb` (fixture-driven from this slice's manifest).

## File-type detection

`FileTypes.detect(path, configured: nil)`:

1. A non-empty `configured` value wins (destination-config override).
2. Otherwise the path is classified by basename/extension, in this exact
   order (first match wins):

| order | rule | type |
|---|---|---|
| 1 | basename `.gitignore` | gitignore |
| 2 | basename `Gemfile` or ends `.gemfile` | gemfile |
| 3 | basename starts `Appraisals` | appraisals |
| 4 | ends `.gemspec` | gemspec |
| 5 | basename `Rakefile` or ext `.rake` | rakefile |
| 6 | Ruby basenames/suffixes/extensions (below) | ruby |
| 7 | ext `.yml`/`.yaml`, or basename `citation.cff` (case-insensitive) | yaml |
| 8 | ext `.toml` | toml |
| 9 | path `.devcontainer/devcontainer.json` | jsonc |
| 10 | ext `.jsonc` / `.json5` / `.json` | jsonc / json5 / json |
| 11 | ext `.md` / `.mdown` | markdown |
| 12 | basename starts `.env`, ends `.env`, or ext `.env` | dotenv |
| 13 | ext `.rbs` | rbs |
| 14 | otherwise | text |

Ruby sets: basenames `Gemfile Rakefile Appraisals Appraisal.root.gemfile
.simplecov`; suffixes `.gemspec .gemfile`; extensions `.rb .rake`.

**Known shadowing (preserved, flagged):** rule 2 fires before rule 3, so
`Appraisal.root.gemfile` classifies as `gemfile`, never `appraisals` — and the
Ruby basenames containing `Gemfile`/`Rakefile`/`Appraisals` are unreachable in
rule 6 for the same reason. This mirrors kettle-jem's effective behavior
(`template_file_type`, `jem.rb:12620`); a cleanup of the dead entries is a
separate decision, not part of extraction. kettle-jem has a second classifier
(`template_file_type_for_relative_path`, used for source reading, not recipe
dispatch) that disagrees; it is NOT extracted — consumers doing dispatch use
this contract.

## Merge dispatch

`MergeDispatch.dispatch(file_type, template_content, destination_content, **options)`:

- A registry maps file type → adapter. The adapter protocol is the merge-gem
  shape: `call(template_source, destination_source, dialect, **options)`
  returning `{ok:, output:, diagnostics:}`.
- Default adapters (lazily required — ast-template does NOT hard-depend on
  merger gems; the consumer's bundle provides them):

  | type | adapter |
  |---|---|
  | yaml | `Psych::Merge.merge_yaml(t, d, "yaml", **options)` |
  | toml | `Citrus::Toml::Merge.merge_toml(t, d, "toml", **options)` |
  | markdown | `Markdown::Merge.merge_markdown(t, d, "markdown", **options)` |

- Types with consumer policy (gemspec, gemfile/ruby family, json*, dotenv,
  rbs, bash, gitignore) have NO default adapter; the consumer registers its
  own (`MergeDispatch.register(type) { |t, d, **opts| ... }`).
- An unregistered type returns nil — the caller's fallback is the template
  content (kettle-jem's `else` branch).
- Merger results pass through untouched; raising on `!ok` with diagnostics is
  the consumer's policy (kettle-jem raises ArgumentError with the joined
  diagnostic messages).

## Fixture anchor

`structuredmerge/fixtures/templating/slice-1043-merge-dispatch/manifest.json`:

- `detection_cases`: path (+ optional configured override) → expected type,
  one per table row plus the shadowing cases.
- `dispatch_cases`: routing proofs against the real default adapters. Each
  case gives type, template, destination, and asserts `ok: true` plus
  `output_contains` substrings (disjoint-content unions where the merged
  output unambiguously contains both sides). Merger *semantics* are pinned by
  the merger gems' own conformance suites; these cases prove only that the
  right merger ran and options passed through.

## Ruby implementation

- `Ast::Template::FileTypes.detect(path, configured: nil)` → Symbol.
- `Ast::Template::MergeDispatch` — `register`, `dispatch`, `registered?`,
  `adapter_for`. Default adapters require their merger gem lazily and raise a
  LoadError naming the gem to add when absent.

kettle-jem delegates: `template_file_type` → `FileTypes.detect`; the yaml,
toml, and markdown branches of `merge_config_template_source` →
`MergeDispatch.dispatch`. Its policy-wrapped types (gemspec, ruby family,
json, dotenv, rbs, bash, gitignore) and the CHANGELOG.md special case stay in
kettle-jem this slice.
