# Slice 46: Conformance Suite Names

## Goal

Define stable suite-selector resolution from the shared manifest.

## Scope

- avoid host-language map iteration drift
- make suite descriptors enumerable through one normalized helper
- establish deterministic suite ordering for later aggregate helpers

## Contract

This slice defines one small suite-selector contract:

1. a manifest suite-selector helper returns all declared suite selectors
2. returned selectors preserve manifest declaration order
3. an absent suite-descriptor section resolves to an empty list

## Shared Fixture

- `suite-names.json`

## Notes

- This slice establishes stable ordering only.
- It does not execute or report suites.
