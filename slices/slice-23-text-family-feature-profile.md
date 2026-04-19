# Slice 23: Text Family Feature Profile

## Goal

Validate the family feature profile pattern against a second merge family.

## Planned Scope

- add a family profile for `text-merge`
- keep the family profile fully descriptive
- make the lack of dialect variants explicit rather than implicit

## Shared Behavior

This slice defines one additional family-level reporting contract:

1. `text-merge` reports family identity as `text`
2. `text-merge` reports an empty dialect list
3. `text-merge` reports an empty policy list until text policies are named
4. the text family profile uses the same core shape as the json family profile

## Shared Types

- `TextFeatureProfile` or equivalent host-language type

## Notes

- This slice tests whether the shared family profile vocabulary is actually
  portable instead of remaining JSON-shaped.
