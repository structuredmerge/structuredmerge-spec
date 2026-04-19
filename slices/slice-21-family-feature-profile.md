# Slice 21: Family Feature Profile

## Goal

Define a normalized feature profile for a document-family merge package.

## Planned Scope

- a minimal family profile shape for `json-merge`
- include family identity, supported dialects, and supported policies
- keep family profiles distinct from adapter-specific profiles

## Shared Behavior

This slice defines one family-level reporting contract:

1. a family feature profile identifies the merge family
2. it reports supported dialects for that family
3. it reports supported policy references for that family
4. it does not require adapter backend identity
5. it remains descriptive rather than executable

## Shared Types

- `JsonFeatureProfile` or equivalent host-language type

## Notes

- This slice intentionally starts with `json-merge`.
- Later slices may generalize the family-level profile pattern across other
  merge families.
