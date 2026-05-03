# Slice 565: Structured Edit Provider Execution Receipt Replay Application

## Goal

Standardize one runnable replay-application record built from a provider
execution receipt replay request.

## Shared Behavior

This slice defines one shared receipt replay-application contract:

1. the replay application carries one shared provider execution receipt
   replay-request record,
2. the replay application carries one shared provider execution run-result
   record,
3. replay-application metadata may remain visible without changing either
   nested execution artifact.

## Notes

- This slice is the first CRISPR-facing replay execution artifact built on top
  of the receipt replay-request line.
