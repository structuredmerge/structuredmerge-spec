# Slice 584: Structured Edit Provider Execution Receipt Replay Workflow Envelope Application

## Goal

Apply a supported replay-workflow envelope back to the shared replay-workflow
 contract.

## Shared Behavior

This slice extends the shared replay-workflow transport contract:

1. importing a supported envelope yields the shared replay-workflow record,
2. the yielded workflow remains compatible with the shared replay-workflow
   contract,
3. replay-workflow transport rejection remains unchanged.

## Notes

- This slice standardizes replay-workflow envelope application, not workflow
  execution.
