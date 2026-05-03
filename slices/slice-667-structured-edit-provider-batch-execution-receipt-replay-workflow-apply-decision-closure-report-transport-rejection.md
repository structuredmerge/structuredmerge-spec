# Slice 667: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Closure Report Transport Rejection

## Goal

Reject malformed or unsupported batch replay-workflow apply-decision
closure-report envelopes.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
closure-report transport rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps batch replay-workflow apply-decision closure-report
  transport validation explicit before higher-level CRISPR closure-reporting
  surfaces build on top of it.
