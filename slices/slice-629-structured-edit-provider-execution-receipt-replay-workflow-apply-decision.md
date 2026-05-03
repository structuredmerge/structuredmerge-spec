# Slice 629: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision

## Goal

Standardize one replay-workflow apply-decision record built from a provider
execution receipt replay-workflow apply result.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision contract:

1. the apply decision carries one shared provider execution receipt
   replay-workflow apply-result record,
2. the apply decision carries one stable `decision` value,
3. apply-decision metadata may remain visible without changing the nested
   replay-workflow apply-result artifact.

## Notes

- This slice is the first CRISPR-facing post-apply decision surface built on
  top of the replay-workflow apply-result line.
