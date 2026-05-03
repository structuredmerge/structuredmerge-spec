# Slice 605: Structured Edit Provider Execution Receipt Replay Workflow Apply Request

## Goal

Standardize one replay-workflow apply-request record built from a provider
execution receipt replay-workflow review request.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-request contract:

1. the apply request carries one shared provider execution receipt replay-workflow
   review-request record,
2. apply-request metadata may remain visible without changing the nested
   replay-workflow review-request artifact.

## Notes

- This slice is the first CRISPR-facing replay-workflow apply surface built on
  top of the replay-workflow review-request line.
