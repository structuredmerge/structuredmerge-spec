# Slice 32: Conformance Suite Summary

## Goal

Add a normalized suite-summary surface above case-by-case conformance results.

## Scope

- summarize runner outcomes without coupling to a test framework
- keep the summary derivable from reported case results
- avoid introducing new outcome categories

## Contract

This slice defines one small summary contract:

1. a conformance suite summary reports `total`, `passed`, `failed`, and
   `skipped`
2. the summary is fully derivable from a list of conformance case results
3. the summary does not replace case-level reporting
4. the summary uses the same normalized outcome vocabulary as case results

## Shared Types

- `ConformanceSuiteSummary`

## Notes

- This slice keeps reporting portable while giving implementations a stable
  aggregate view for logs, CI surfaces, or future reusable runners.
