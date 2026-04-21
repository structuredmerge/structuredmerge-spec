# Slice 54: Named Conformance Suite Summary

## Goal

Summarize ordered suite-descriptor report entries through one aggregate summary.

## Scope

- compose suite-descriptor reports with a manifest-wide summary
- preserve existing suite-level summaries
- avoid reimplementing aggregate summary math in each host language

## Contract

This slice defines one small aggregate summary contract:

1. an aggregate suite-descriptor summary helper consumes ordered
   suite-descriptor report entries
2. it sums their embedded suite summaries
3. it returns one `ConformanceSuiteSummary`

## Shared Fixture

- `named-suite-summary.json`
