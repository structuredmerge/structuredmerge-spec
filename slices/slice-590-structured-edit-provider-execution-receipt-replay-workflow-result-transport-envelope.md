# Slice 590: Structured Edit Provider Execution Receipt Replay Workflow Result Transport Envelope

## Goal

Standardize transport export and import for one provider execution receipt
replay-workflow result.

## Shared Behavior

This slice defines one shared replay-workflow result envelope contract:

1. exporting a replay-workflow result yields an envelope with a stable `kind`,
   shared transport `version`, and one nested replay-workflow result payload,
2. importing the same envelope yields the original replay-workflow result
   without changing nested replay artifacts.

## Notes

- This slice standardizes transport for the replay-workflow result surface, not
  executor behavior.
