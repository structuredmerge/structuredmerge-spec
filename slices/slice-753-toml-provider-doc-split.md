# Slice 753: TOML Provider Documentation Split

## Goal

Split the old `toml-merge` README value into portable TOML family semantics
and backend/provider-specific parser documentation.

The old README presented `toml-merge` as a Ruby gem with multiple TreeHaver
parser backends: tree-sitter TOML, Parslet + `toml`, and Citrus + `toml-rb`.
The current structured-merge workspace has a cross-language `toml-merge`
family package and separate provider packages where a language exposes a
specific parser backend.

## General TOML Semantics

The following old README value belongs to the current TOML family:

- TOML parse success and parse failure.
- TOML table/root-table structure.
- key/value owner extraction.
- table and array structure recognition.
- path/equality owner matching.
- recursive table merge.
- destination-wins scalar conflicts.
- destination-wins array policy.
- nested table leaf merge.
- package-specific TOML usage examples once public APIs are stable.

## Provider-Specific Docs

The following old README value should be provider-specific:

- `Citrus::Toml::Merge` parser/backend behavior.
- `Parslet::Toml::Merge` parser/backend behavior.
- tree-sitter or language-pack backend selection and platform notes.
- Ruby-only parser gems such as `toml`, `toml-rb`, and their runtime limits.
- provider feature profiles, plan contexts, and named-suite coverage.

## Future Fixture Work

The following old behavior should not be copied into generated `toml-merge`
README examples until portable fixtures define the behavior:

- table fuzzy matching through `TableMatchRefiner`;
- key sorting through `KeySorter`;
- comment-preserving TOML output;
- adjacent table comment transfer;
- array-of-tables comment transfer;
- TOML emitter formatting;
- freeze blocks, if retained for TOML.

## Existing Coverage

Current TOML fixtures already cover the baseline TOML family behavior:

- feature profile;
- parse success and parse errors;
- table and array owner extraction;
- path/equality owner matching;
- recursive table merge;
- advanced nested table leaf merge;
- backend feature profiles and plan contexts;
- provider feature profiles, plan contexts, named-suite plans, and manifest
  reports.

## Decision

`toml-merge` owns portable TOML family docs. Provider packages such as
`citrus-toml-merge`, `parslet-toml-merge`, `pest-toml-merge`,
`peggy-toml-merge`, and any Go provider package own parser-specific docs.

Old Ruby parser/backend tables are prior art. Current generated READMEs should
describe provider packages through fixture-backed provider metadata, not as a
Ruby-only platform compatibility promise.
