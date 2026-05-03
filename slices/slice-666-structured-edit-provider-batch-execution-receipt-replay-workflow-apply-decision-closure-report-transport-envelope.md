# Slice 666: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Closure Report Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow
apply-decision closure-report record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
closure-report transport contract:

1. exporting a batch closure-report yields an envelope with a stable `kind`
   and transport `version`,
2. importing that envelope reproduces the same batch closure-report record.

## Notes

- This slice keeps the batch post-confirmation closure artifact
  transportable without flattening nested closure-report records.
