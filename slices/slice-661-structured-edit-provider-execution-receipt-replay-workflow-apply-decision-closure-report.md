# Slice 661: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Closure Report

## Goal

Standardize one replay-workflow apply-decision closure-report record built
from a provider execution receipt replay-workflow apply-decision
confirmation.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
closure-report contract:

1. the closure-report carries one shared provider execution receipt
   replay-workflow apply-decision confirmation record,
2. the closure-report carries one stable `closure_report` value,
3. closure-report metadata may remain visible without changing the nested
   replay-workflow apply-decision confirmation artifact.

## Notes

- This slice is the next CRISPR-facing closure artifact built on top of the
  replay-workflow apply-decision confirmation line.
