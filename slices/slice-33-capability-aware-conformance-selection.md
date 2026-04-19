# Slice 33: Capability-Aware Conformance Selection

## Goal

Define a portable way for conformance runners to skip or select cases based on
declared capability and backend support.

## Scope

- connect feature profiles to conformance selection
- keep skipped cases observable rather than silently dropped
- avoid binding conformance selection to any one host-language backend

## Contract

This slice defines one small capability-aware selection contract:

1. a conformance case may declare optional capability requirements through
   `dialect` and `policies`
2. selection evaluates those requirements against a family feature profile and
   an optional backend feature profile
3. unsupported requirements produce a normalized `skipped` selection rather than
   silently removing the case
4. supported requirements produce a normalized `selected` selection
5. non-default dialect requests are backend-sensitive when a backend profile
   reports `supports_dialects: false`

## Shared Types

- `ConformanceCaseRequirements`
- `ConformanceSelectionStatus`
- `ConformanceCaseSelection`

## Notes

- This slice is planned ahead because the current backend-backed JSON adapter
  path is already narrower than whole-family support.
- The default dialect for a family is its stable family name, for example
  `json` for the `json` family.
