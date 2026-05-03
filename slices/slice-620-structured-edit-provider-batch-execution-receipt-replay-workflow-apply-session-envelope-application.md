# Slice 620: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Session Envelope Application

## Goal

Standardize import and application of a supported provider batch execution
receipt replay-workflow apply-session envelope.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-session
envelope application surface:

1. importing a supported envelope returns the shared provider batch execution
   receipt replay-workflow apply-session record unchanged,
2. supported imports preserve the nested single apply-session artifacts,
3. rejected imports still return the shared transport rejection errors from the
   rejection slice.

## Notes

- This slice completes the batch CRISPR-facing replay-workflow apply-session
  transport line.
