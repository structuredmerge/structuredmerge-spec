# Slice 592: Structured Edit Provider Execution Receipt Replay Workflow Result Envelope Application

## Goal

Apply one accepted provider execution receipt replay-workflow result envelope.

## Shared Behavior

This slice defines shared replay-workflow result envelope-application behavior:

1. importing a supported replay-workflow result envelope yields the expected
   replay-workflow result payload,
2. rejected envelopes keep the same transport error behavior defined by the
   rejection slice.

## Notes

- This slice proves the replay-workflow result envelope can be applied as a
  reusable CRISPR-facing artifact.
