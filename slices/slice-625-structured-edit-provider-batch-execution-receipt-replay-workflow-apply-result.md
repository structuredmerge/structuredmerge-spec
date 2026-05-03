# Slice 625: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Result

## Goal

Standardize one batch replay-workflow apply-result record built from provider
execution receipt replay-workflow apply results.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-result
contract:

1. the batch apply result carries ordered shared provider execution receipt
   replay-workflow apply-result records,
2. batch apply-result metadata may remain visible without changing nested
   replay-workflow apply-result artifacts.

## Notes

- This slice is the batch CRISPR-facing replay-workflow apply-result surface
  built on top of the single apply-result line.
