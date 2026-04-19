# Slice 46: Conformance Suite Names

## Goal

Define stable suite-name resolution from the shared manifest.

## Scope

- avoid host-language map iteration drift
- make named suites enumerable through one normalized helper
- establish deterministic suite ordering for later aggregate helpers

## Contract

This slice defines one small suite-name contract:

1. a manifest suite-name helper returns all declared suite names
2. returned names are sorted in ascending lexical order
3. an absent `suites` section resolves to an empty list

## Shared Fixture

- `suite-names.json`

## Notes

- This slice establishes stable ordering only.
- It does not execute or report suites.
