# Slice 750: YAML/Psych Documentation Split

## Goal

Split the old `psych-merge` README value into general YAML family semantics and
Psych-specific Ruby backend/provider documentation.

The old README presents `Psych::Merge` as the YAML merge package because Psych
was the Ruby parser implementation. The current structured-merge workspace has
a cross-language `yaml-merge` family and treats Psych as Ruby backend/provider
prior art.

## General YAML Semantics

The following old README value belongs to the current YAML family:

- YAML mapping, sequence, scalar, and alias concepts,
- mapping-root YAML parse behavior,
- recursive mapping merge,
- destination-wins scalar conflicts,
- destination-wins sequence policy,
- template-only and destination-only key preservation,
- path/equality owner matching,
- package-specific YAML usage examples once public APIs are stable.

## Psych-Specific Or Future Provider Docs

The following old README value should not be copied into cross-language
`yaml-merge` docs as-is:

- `Psych::Merge::*` class names and Ruby require paths,
- Psych runtime/backend support claims,
- Ruby-only `PSYCH_MERGE_DEBUG` textual debug logging,
- `MappingMatchRefiner` class API and weights,
- comment-preserving emitter behavior,
- freeze-block node classes and default `psych-merge` token,
- partial-template/diff mapper internals.

Those items require either provider-specific Ruby docs or new portable
fixtures before becoming current README claims.

## Existing Coverage

Current YAML fixtures already cover the baseline YAML family behavior:

- feature profile,
- parse success and parse errors,
- mapping and sequence owner extraction,
- path-equality owner matching,
- recursive mapping merge,
- advanced nested mapping leaf merge,
- backend feature profiles and plan contexts.

## Boundary

This slice is a documentation/value split. It does not implement fuzzy mapping
matching, freeze blocks, comment preservation, or backend-specific Psych
wrappers.
