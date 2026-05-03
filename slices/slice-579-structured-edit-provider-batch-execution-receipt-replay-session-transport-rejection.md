# Slice 579: Structured Edit Provider Batch Execution Receipt Replay Session Transport Rejection

## Goal

Standardize rejection behavior when a batch provider execution receipt replay
session envelope cannot be imported.

## Shared Behavior

This slice defines shared batch replay-session envelope rejection behavior:

1. importing rejects envelopes with the wrong `kind`,
2. importing rejects envelopes with an unsupported `version`,
3. rejection diagnostics stay transport-focused rather than reinterpreting the
   batch replay-session payload.

## Notes

- This slice standardizes transport rejection, not batch replay-session
  validation.
