# Slice 617: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Session

## Goal

Standardize one batch replay-workflow apply-session record built from provider
execution receipt replay-workflow apply sessions.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-session
contract:

1. the batch apply session carries ordered shared provider execution receipt
   replay-workflow apply-session records,
2. batch apply-session metadata may remain visible without changing nested
   replay-workflow apply-session artifacts.

## Notes

- This slice is the batch CRISPR-facing replay-workflow apply-session surface
  built on top of the single apply-session line.
