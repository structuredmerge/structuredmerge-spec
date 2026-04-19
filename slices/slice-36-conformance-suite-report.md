# Slice 36: Conformance Suite Report

## Goal

Define a normalized suite-report envelope that combines ordered case results
with a derived suite summary.

## Scope

- keep the report directly derivable from existing case results
- preserve case ordering
- avoid introducing any new outcome or summary categories

## Contract

This slice defines one small suite-report contract:

1. a suite report contains an ordered `results` list of
   `ConformanceCaseResult`
2. a suite report contains a derived `summary` using the slice-32 summary
   contract
3. the summary is computed from the enclosed result list rather than supplied by
   a separate hidden source
4. the report remains transportable and independent of any host test framework

## Shared Types

- `ConformanceSuiteReport`
- `ConformanceCaseResult`
- `ConformanceSuiteSummary`

## Notes

- This slice is a reporting envelope, not a new execution flow.
- It composes directly above slice-35 suite-runner behavior.
