# Slice 623: Structured Edit Provider Execution Receipt Replay Workflow Apply Result Transport Rejection

## Goal

Standardize transport rejection for unsupported provider execution receipt
replay-workflow apply-result envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-result transport
rejection surface:

1. importing the wrong envelope kind returns a `kind_mismatch` error,
2. importing an unsupported envelope version returns an
   `unsupported_version` error.

## Notes

- This slice preserves the same transport hardening used by the surrounding
  CRISPR replay/apply artifacts.
