# Slice 596: Structured Edit Provider Batch Execution Receipt Replay Workflow Result Envelope Application

## Goal

Apply one accepted provider batch execution receipt replay-workflow result
envelope.

## Shared Behavior

This slice defines shared batch replay-workflow result envelope-application
behavior:

1. importing a supported batch replay-workflow result envelope yields the
   expected batch replay-workflow result payload,
2. rejected envelopes keep the same transport error behavior defined by the
   rejection slice.

## Notes

- This slice proves the batch replay-workflow result envelope can be applied as
  a reusable CRISPR-facing artifact.
