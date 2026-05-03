# Slice 589: Structured Edit Provider Execution Receipt Replay Workflow Result

## Goal

Standardize one replay-workflow result record built from a provider execution
receipt replay workflow.

## Shared Behavior

This slice defines one shared receipt replay-workflow result contract:

1. the replay-workflow result carries one shared provider execution receipt
   replay-workflow record,
2. the replay-workflow result carries one shared provider execution receipt
   replay-application record,
3. replay-workflow result metadata may remain visible without changing either
   nested replay artifact.

## Notes

- This slice is the first CRISPR-facing replay-workflow result artifact built
  on top of the replay-workflow line.
