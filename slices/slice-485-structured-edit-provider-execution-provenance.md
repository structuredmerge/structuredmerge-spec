# Slice 485: Structured Edit Provider Execution Provenance

## Goal

Standardize an executor-facing provenance record for a single provider-routed
structured edit run.

## Shared Behavior

This slice defines one shared provenance contract:

1. the record carries the resolved execution dispatch,
2. the record carries the resulting execution outcome,
3. shared diagnostics and metadata may remain visible without changing either
   dispatch or outcome.

## Notes

- This slice standardizes provenance shape, not provenance transport.
