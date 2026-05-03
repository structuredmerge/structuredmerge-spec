# Slice 635: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Transport Rejection

## Goal

Reject malformed or unsupported batch replay-workflow apply-decision envelopes.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
transport rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps batch replay-workflow apply-decision transport validation
  explicit before higher-level CRISPR workflow decision surfaces build on top of
  it.
