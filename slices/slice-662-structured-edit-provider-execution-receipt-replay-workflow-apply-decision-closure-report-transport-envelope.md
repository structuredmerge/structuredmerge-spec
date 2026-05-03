# Slice 662: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Closure Report Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply-decision
closure-report record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
closure-report transport contract:

1. exporting a closure-report yields an envelope with a stable `kind` and
   transport `version`,
2. importing that envelope reproduces the same closure-report record.

## Notes

- This slice keeps the post-confirmation closure artifact transportable
  without flattening the nested confirmation record.
