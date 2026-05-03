# Slice 586: Structured Edit Provider Batch Execution Receipt Replay Workflow Transport Envelope

## Goal

Standardize a versioned transport envelope for a batch of provider execution
receipt replay-workflow records.

## Shared Behavior

This slice extends the shared batch replay-workflow contract:

1. exporting a batch replay workflow yields an envelope with a stable `kind`,
2. the envelope carries one shared batch replay-workflow record,
3. importing a supported envelope round-trips the batch replay-workflow record.

## Notes

- This slice standardizes batch replay-workflow transport, not batch replay
  execution.
