# Slice 639: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Outcome Transport Rejection

## Goal

Reject malformed or unsupported replay-workflow apply-decision outcome
envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision outcome
transport rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps replay-workflow apply-decision outcome transport validation
  explicit before higher-level CRISPR workflow review or settlement surfaces
  build on top of it.
