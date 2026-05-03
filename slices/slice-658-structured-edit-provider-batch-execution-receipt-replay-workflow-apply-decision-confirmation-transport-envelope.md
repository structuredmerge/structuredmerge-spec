# Slice 658: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Confirmation Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow
apply-decision confirmation record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
confirmation transport contract:

1. exporting a batch apply-decision confirmation yields an envelope with a
   stable `kind` and transport `version`,
2. importing that envelope reproduces the same batch apply-decision
   confirmation record.

## Notes

- This slice keeps the batch post-settlement confirmation artifact
  transportable without flattening nested confirmation records.
