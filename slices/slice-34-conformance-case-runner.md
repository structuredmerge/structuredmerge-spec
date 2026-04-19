# Slice 34: Conformance Case Runner

## Goal

Define a normalized helper for running one conformance case through capability
selection and observable case-result reporting.

## Scope

- keep skipped cases observable through ordinary case results
- separate pre-execution selection from selected-case execution
- avoid coupling to a specific test runner or assertion library

## Contract

This slice defines one small case-runner contract:

1. a conformance case runner first performs capability-aware selection
2. when selection skips the case, the runner returns a normalized
   `ConformanceCaseResult` with outcome `skipped`
3. when selection chooses the case, the runner invokes an execution callback
4. the runner preserves the stable case reference in both skipped and executed
   results
5. the runner does not replace selection reporting; it builds on slice-33

## Shared Types

- `ConformanceCaseRun`
- `ConformanceCaseExecution`
- `ConformanceCaseResult`

## Notes

- This slice keeps execution callback shape intentionally small.
- It is the bridge between abstract conformance selection and reusable suite
  execution.
