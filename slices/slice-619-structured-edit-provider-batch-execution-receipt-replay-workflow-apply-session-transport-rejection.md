# Slice 619: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Session Transport Rejection

## Goal

Standardize transport rejection for unsupported provider batch execution
receipt replay-workflow apply-session envelopes.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-session
transport rejection surface:

1. importing the wrong envelope kind returns a `kind_mismatch` error,
2. importing an unsupported envelope version returns an
   `unsupported_version` error.

## Notes

- This slice keeps batch replay-workflow apply-session transport validation
  aligned with the single CRISPR-facing line.
