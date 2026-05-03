# Slice 621: Structured Edit Provider Execution Receipt Replay Workflow Apply Result

## Goal

Standardize one replay-workflow apply-result record built from a provider
execution receipt replay-workflow apply session.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-result contract:

1. the apply result carries one shared provider execution receipt replay-workflow
   apply-session record,
2. the apply result carries one shared provider execution receipt replay-workflow
   result record,
3. apply-result metadata may remain visible without changing either nested
   replay artifact.

## Notes

- This slice is the first CRISPR-facing post-apply artifact built on top of the
  replay-workflow apply-session line.
