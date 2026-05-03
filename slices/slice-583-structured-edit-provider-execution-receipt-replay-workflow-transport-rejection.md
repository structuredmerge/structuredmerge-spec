# Slice 583: Structured Edit Provider Execution Receipt Replay Workflow Transport Rejection

## Goal

Reject unsupported transport envelopes for a provider execution receipt replay
workflow.

## Shared Behavior

This slice extends the shared replay-workflow transport contract:

1. importing rejects an envelope whose `kind` does not match the replay-workflow
   transport kind,
2. importing rejects an envelope whose `version` is unsupported,
3. rejection reports the shared transport import error vocabulary.

## Notes

- This slice standardizes replay-workflow transport rejection, not replay
  validation.
