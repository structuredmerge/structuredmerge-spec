# Slice 633: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision

## Goal

Standardize one batch replay-workflow apply-decision record built from provider
execution receipt replay-workflow apply decisions.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
contract:

1. the batch apply decision carries ordered shared provider execution receipt
   replay-workflow apply-decision records,
2. batch apply-decision metadata may remain visible without changing nested
   replay-workflow apply-decision artifacts.

## Notes

- This slice is the batch CRISPR-facing replay-workflow apply-decision surface
  built on top of the single apply-decision line.
