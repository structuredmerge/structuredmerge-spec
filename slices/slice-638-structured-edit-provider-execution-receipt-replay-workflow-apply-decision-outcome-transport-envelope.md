# Slice 638: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Outcome Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply-decision outcome
record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision outcome
transport contract:

1. exporting a replay-workflow apply-decision outcome yields an envelope with a
   stable `kind` and transport `version`,
2. importing that envelope reproduces the same replay-workflow apply-decision
   outcome record.

## Notes

- This slice keeps the first post-decision outcome artifact transportable
  without flattening the nested apply-decision record.
