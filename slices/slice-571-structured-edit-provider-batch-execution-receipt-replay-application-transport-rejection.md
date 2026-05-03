# Slice 571: Structured Edit Provider Batch Execution Receipt Replay Application Transport Rejection

## Goal

Standardize rejection behavior when a batch provider execution receipt replay
application envelope cannot be imported.

## Shared Behavior

This slice defines shared batch replay-application envelope rejection behavior:

1. importing rejects envelopes with the wrong `kind`,
2. importing rejects envelopes with an unsupported `version`,
3. rejection diagnostics stay transport-focused rather than reinterpreting the
   batch replay-application payload.

## Notes

- This slice standardizes transport rejection, not batch replay-application
  validation.
