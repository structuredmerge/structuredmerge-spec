# Slice 655: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Confirmation Transport Rejection

## Goal

Reject malformed or unsupported replay-workflow apply-decision confirmation
envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
confirmation transport rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps replay-workflow apply-decision confirmation transport
  validation explicit before higher-level CRISPR closure reporting surfaces
  build on top of it.
