# Slice 573: Structured Edit Provider Execution Receipt Replay Session

## Goal

Standardize one reusable replay-session record built from a provider execution
receipt replay application.

## Shared Behavior

This slice defines one shared receipt replay-session contract:

1. the replay session carries one shared provider execution receipt replay
   application record,
2. the replay session carries one shared provider execution receipt record,
3. replay-session metadata may remain visible without changing either nested
   execution artifact.

## Notes

- This slice is the first CRISPR-facing reusable replay-session artifact built
  on top of the replay-application line.
