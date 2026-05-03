# Slice 631: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Transport Rejection

## Goal

Reject malformed or unsupported replay-workflow apply-decision envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision transport
rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps replay-workflow apply-decision transport validation explicit
  before higher-level CRISPR workflow decisions build on top of it.
