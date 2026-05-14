# Slice 754: TOML Fixture Coverage Verification

## Goal

Verify which old `toml-merge` behaviors are already fixture-backed by the
current TOML family and which old values still require portable fixtures before
they can appear in generated README examples.

## Sources

The old TOML implementation provided behavior in these areas:

- `Toml::Merge::ConflictResolver`
- `Toml::Merge::TableMatchRefiner`
- `Toml::Merge::KeySorter`
- `Toml::Merge::CommentTracker`
- `Toml::Merge::Emitter`
- `Toml::Merge::SmartMerger`
- reproducible merge fixtures under
  `reference/toml-merge/spec/fixtures/reproducible/`

## Current Fixture-Backed Claims

The current TOML family can claim these behaviors:

- TOML parse success and parse failure.
- Table and array owner extraction.
- Path/equality owner matching.
- Recursive table merge.
- Destination-wins scalar conflict behavior.
- Destination-wins array policy.
- Nested table leaf merge.
- Family and provider backend metadata.

These are covered by `fixtures/toml/slice-91-parse/`,
`fixtures/toml/slice-92-structure/`, `fixtures/toml/slice-93-matching/`,
`fixtures/toml/slice-94-merge/`,
`fixtures/toml/slice-720-advanced-leaf-merge/`, and TOML backend/provider
diagnostic fixtures.

## Missing Fixture Obligations

The following old values are not current README claims yet:

- Fuzzy table matching. Old examples matched `server` with `servers`, rejected
  very different names at high thresholds, used name similarity, key overlap,
  position similarity, configurable weights, and greedy one-to-one match
  results.
- Key sorting. Old `KeySorter` sorted key/value lines alphabetically within
  gap-separated blocks, kept leading comments attached to the following key,
  and treated blank lines plus table/array-of-table headers as boundaries.
- Comment-preserving table output. Old examples preserved destination leading
  and inline comments under template preference, preserved docs for adjacent
  matched tables, handled first-node preambles, deduplicated repeated shared
  preambles, and promoted comments from removed destination-only keys.
- Array-of-tables comment transfer. Old reproducible fixtures covered template
  preference while keeping destination docs on matched array-of-tables entries.
- Template preference and add/remove policy beyond the current baseline.
  Current fixtures document destination-wins behavior; old tests also covered
  template preference, template-only section insertion, and removal-mode comment
  handling.
- Inline tables and emitter formatting. Old tests exercised inline table nodes,
  arrays, output formatting, and emitter/comment placement behavior that is not
  yet a portable fixture.
- Freeze blocks. Old tests mention preserving destination nodes under a freeze
  decision, but no current TOML marker/profile fixture exists.

## Decision

Keep generated TOML README examples limited to fixture-backed family behavior.
Port the old advanced TOML feature set through future portable fixture slices
before implementation or README claims.

The old Ruby APIs are prior art for fixture design, not the cross-language
contract by themselves.
