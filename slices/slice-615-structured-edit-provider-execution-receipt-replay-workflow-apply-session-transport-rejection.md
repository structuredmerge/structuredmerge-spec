# Slice 615: Structured Edit Provider Execution Receipt Replay Workflow Apply Session Transport Rejection

## Goal

Standardize transport rejection for unsupported provider execution receipt
replay-workflow apply-session envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-session transport
rejection surface:

1. importing the wrong envelope kind returns a `kind_mismatch` error,
2. importing an unsupported envelope version returns an
   `unsupported_version` error.

## Notes

- This slice preserves the same transport hardening used by the other CRISPR
  replay artifacts.
