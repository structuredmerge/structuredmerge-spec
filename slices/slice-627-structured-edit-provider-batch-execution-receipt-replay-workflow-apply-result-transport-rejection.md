# Slice 627: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Result Transport Rejection

## Goal

Standardize transport rejection for unsupported provider batch execution
receipt replay-workflow apply-result envelopes.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-result
transport rejection surface:

1. importing the wrong envelope kind returns a `kind_mismatch` error,
2. importing an unsupported envelope version returns an
   `unsupported_version` error.

## Notes

- This slice keeps batch replay-workflow apply-result transport validation
  aligned with the single CRISPR-facing line.
