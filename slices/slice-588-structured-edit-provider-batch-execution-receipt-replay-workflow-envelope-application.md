# Slice 588: Structured Edit Provider Batch Execution Receipt Replay Workflow Envelope Application

## Goal

Apply a supported batch replay-workflow envelope back to the shared batch
replay-workflow contract.

## Shared Behavior

This slice extends the shared batch replay-workflow transport contract:

1. importing a supported envelope yields the shared batch replay-workflow
   record,
2. the yielded batch remains compatible with the shared batch replay-workflow
   contract,
3. batch replay-workflow transport rejection remains unchanged.

## Notes

- This slice standardizes batch replay-workflow envelope application, not batch
  replay execution.
