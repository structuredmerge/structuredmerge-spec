# Slice 35: Conformance Suite Runner

## Goal

Define a normalized helper for running a portable list of conformance cases
through one case-runner flow.

## Scope

- preserve case ordering
- keep skipped cases in the emitted result list
- avoid embedding summary logic into the runner itself

## Contract

This slice defines one small suite-runner contract:

1. a suite runner accepts an ordered list of portable case runs
2. it produces one ordered list of `ConformanceCaseResult`
3. each case result is produced through the slice-34 case-runner behavior
4. skipped cases remain present in the returned list
5. suite summary remains a separate derived step using slice-32

## Shared Types

- `ConformanceCaseRun`
- `ConformanceCaseResult`

## Notes

- The suite runner is intentionally list-oriented and transportable.
- It does not standardize filesystem lookup, fixture decoding, or assertion
  semantics.
