# Slice 41: Planned Conformance Suite Report

## Goal

Define a normalized report helper layered directly on top of a planned
conformance suite.

## Scope

- compose planned-suite execution with suite reporting
- preserve the planned entry order in the report
- avoid introducing a second report shape

## Contract

This slice defines one small planned-suite report contract:

1. a planned-suite report helper consumes one `ConformanceSuitePlan`
2. it executes the plan through the planned-suite runner
3. it returns the existing `ConformanceSuiteReport` shape
4. the report summary is derived from the executed result list
5. missing roles remain a planning concern and do not create synthetic report
   rows

## Shared Fixture

- `planned-suite-report.json`

## Notes

- This slice is a composition helper, not a new reporting model.
- It completes the manifest-driven path from slice-39 planning through slice-40
  planned execution into the existing suite-report envelope.
