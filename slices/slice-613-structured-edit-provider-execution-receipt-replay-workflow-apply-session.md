# Slice 613: Structured Edit Provider Execution Receipt Replay Workflow Apply Session

## Goal

Standardize one reusable replay-workflow apply-session record built from a
provider execution receipt replay-workflow apply request.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-session contract:

1. the apply session carries one shared provider execution receipt
   replay-workflow apply-request record,
2. the apply session carries one shared provider execution receipt replay-session
   record,
3. apply-session metadata may remain visible without changing either nested
   replay artifact.

## Notes

- This slice is the first CRISPR-facing replay-workflow apply-session surface
  built on top of the explicit replay-workflow apply-request line.
