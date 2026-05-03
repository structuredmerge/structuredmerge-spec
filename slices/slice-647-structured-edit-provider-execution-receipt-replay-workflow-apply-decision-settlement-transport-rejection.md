# Slice 647: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Settlement Transport Rejection

## Goal

Reject malformed or unsupported replay-workflow apply-decision settlement
envelopes.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
settlement transport rejection contract:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- This slice keeps replay-workflow apply-decision settlement transport
  validation explicit before higher-level CRISPR workflow confirmation or
  closure surfaces build on top of it.
