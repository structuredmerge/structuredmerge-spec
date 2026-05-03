# Slice 634: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow apply-decision
record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
transport contract:

1. exporting a batch replay-workflow apply decision yields an envelope with a
   stable `kind` and transport `version`,
2. importing that envelope reproduces the same batch replay-workflow
   apply-decision record.

## Notes

- This slice keeps batch post-apply decisions transportable without flattening
  the nested single apply-decision records.
