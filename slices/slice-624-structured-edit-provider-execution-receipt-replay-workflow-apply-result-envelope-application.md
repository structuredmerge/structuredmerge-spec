# Slice 624: Structured Edit Provider Execution Receipt Replay Workflow Apply Result Envelope Application

## Goal

Standardize import and application of a supported provider execution receipt
replay-workflow apply-result envelope.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-result envelope
application surface:

1. importing a supported envelope returns the shared provider execution receipt
   replay-workflow apply-result record unchanged,
2. supported imports preserve the nested replay-workflow apply-session and
   replay-workflow result artifacts,
3. rejected imports still return the shared transport rejection errors from the
   rejection slice.

## Notes

- This slice completes the single CRISPR-facing replay-workflow apply-result
  transport line.
