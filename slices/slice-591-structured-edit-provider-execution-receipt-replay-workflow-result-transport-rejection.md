# Slice 591: Structured Edit Provider Execution Receipt Replay Workflow Result Transport Rejection

## Goal

Reject invalid transport envelopes for one provider execution receipt replay-
workflow result.

## Shared Behavior

This slice defines shared replay-workflow result transport rejection behavior:

1. import rejects an envelope whose `kind` does not identify a replay-workflow
   result,
2. import rejects an envelope whose `version` is not supported,
3. rejection surfaces a stable structured transport error.

## Notes

- This slice hardens replay-workflow result transport without changing the
  replay-workflow result payload.
