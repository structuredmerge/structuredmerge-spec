# Slice 597: Structured Edit Provider Execution Receipt Replay Workflow Review Request

## Goal

Standardize one replay-workflow review-request record built from a provider
execution receipt replay-workflow result.

## Shared Behavior

This slice defines one shared receipt replay-workflow review-request contract:

1. the review request carries one shared provider execution receipt replay-workflow
   result record,
2. review-request metadata may remain visible without changing the nested
   replay-workflow result artifact.

## Notes

- This slice is the first CRISPR-facing replay-workflow review surface built on
  top of the replay-workflow result line.
