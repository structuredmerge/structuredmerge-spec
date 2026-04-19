# Slice 42: Manifest Case Requirements

## Goal

Define optional case requirements directly on conformance manifest entries.

## Scope

- let manifest entries declare dialect or policy requirements
- propagate declared requirements through suite planning
- preserve the empty-requirements default for entries that declare nothing

## Contract

This slice defines one small manifest-requirements contract:

1. a conformance manifest entry may declare optional `requirements`
2. declared requirements use the existing `ConformanceCaseRequirements` shape
3. suite planning copies declared manifest requirements into the generated run
4. entries with no declared requirements still generate empty requirements
5. selection and execution semantics remain unchanged; this slice only changes
   how planned runs are populated

## Shared Fixture

- `manifest-requirements.json`

## Notes

- This slice turns the manifest from a path index into a light-weight case
  declaration surface.
- It is the first place where manifest-driven planning can express non-default
  dialect intent directly.
