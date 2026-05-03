# Slice 642: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Outcome Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow apply-decision
outcome record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
outcome transport contract:

1. exporting a batch replay-workflow apply-decision outcome yields an envelope
   with a stable `kind` and transport `version`,
2. importing that envelope reproduces the same batch replay-workflow
   apply-decision outcome record.

## Notes

- This slice keeps batch post-decision outcome artifacts transportable without
  flattening the nested single apply-decision outcome records.
