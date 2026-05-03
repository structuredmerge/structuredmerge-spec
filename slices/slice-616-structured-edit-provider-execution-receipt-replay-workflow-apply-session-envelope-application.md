# Slice 616: Structured Edit Provider Execution Receipt Replay Workflow Apply Session Envelope Application

## Goal

Standardize import and application of a supported provider execution receipt
replay-workflow apply-session envelope.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-session envelope
application surface:

1. importing a supported envelope returns the shared provider execution receipt
   replay-workflow apply-session record unchanged,
2. supported imports preserve the nested replay-workflow apply-request and
   replay-session artifacts,
3. rejected imports still return the shared transport rejection errors from the
   rejection slice.

## Notes

- This slice completes the single CRISPR-facing replay-workflow apply-session
  transport line.
