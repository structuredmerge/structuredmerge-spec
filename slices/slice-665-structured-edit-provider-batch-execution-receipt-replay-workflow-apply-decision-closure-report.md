# Slice 665: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Closure Report

## Goal

Standardize one batch replay-workflow apply-decision closure-report record
built from provider execution receipt replay-workflow apply-decision
closure-reports.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
closure-report contract:

1. the batch closure-report carries ordered shared provider execution receipt
   replay-workflow apply-decision closure-report records,
2. batch closure-report metadata may remain visible without changing nested
   replay-workflow apply-decision closure-report artifacts.

## Notes

- This slice is the batch CRISPR-facing replay-workflow apply-decision
  closure-report surface built on top of the single closure-report line.
