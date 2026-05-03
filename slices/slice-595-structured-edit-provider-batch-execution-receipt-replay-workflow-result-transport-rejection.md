# Slice 595: Structured Edit Provider Batch Execution Receipt Replay Workflow Result Transport Rejection

## Goal

Reject invalid transport envelopes for one provider batch execution receipt
replay-workflow result.

## Shared Behavior

This slice defines shared batch replay-workflow result transport rejection
behavior:

1. import rejects an envelope whose `kind` does not identify a batch replay-
   workflow result,
2. import rejects an envelope whose `version` is not supported,
3. rejection surfaces a stable structured transport error.

## Notes

- This slice hardens batch replay-workflow result transport without changing
  the batch replay-workflow result payload.
