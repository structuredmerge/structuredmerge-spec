# Slice 654: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Confirmation Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply-decision
confirmation record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
confirmation transport contract:

1. exporting an apply-decision confirmation yields an envelope with a stable
   `kind` and transport `version`,
2. importing that envelope reproduces the same apply-decision confirmation
   record.

## Notes

- This slice keeps the post-settlement confirmation artifact transportable
  without flattening the nested settlement record.
