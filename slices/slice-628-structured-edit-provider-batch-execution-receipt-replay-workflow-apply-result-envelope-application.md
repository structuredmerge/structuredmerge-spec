# Slice 628: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Result Envelope Application

## Goal

Standardize import and application of a supported provider batch execution
receipt replay-workflow apply-result envelope.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-result
envelope application surface:

1. importing a supported envelope returns the shared provider batch execution
   receipt replay-workflow apply-result record unchanged,
2. supported imports preserve the nested single apply-result artifacts,
3. rejected imports still return the shared transport rejection errors from the
   rejection slice.

## Notes

- This slice completes the batch CRISPR-facing replay-workflow apply-result
  transport line.
