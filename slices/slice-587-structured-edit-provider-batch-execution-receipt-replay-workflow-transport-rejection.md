# Slice 587: Structured Edit Provider Batch Execution Receipt Replay Workflow Transport Rejection

## Goal

Reject unsupported transport envelopes for a batch provider execution receipt
replay workflow.

## Shared Behavior

This slice extends the shared batch replay-workflow transport contract:

1. importing rejects an envelope whose `kind` does not match the batch
   replay-workflow transport kind,
2. importing rejects an envelope whose `version` is unsupported,
3. rejection reports the shared transport import error vocabulary.

## Notes

- This slice standardizes batch replay-workflow transport rejection, not batch
  replay validation.
