# Slice 650: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Settlement Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow apply-decision
settlement record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-decision
settlement transport contract:

1. exporting a batch replay-workflow apply-decision settlement yields an
   envelope with a stable `kind` and transport `version`,
2. importing that envelope reproduces the same batch replay-workflow
   apply-decision settlement record.

## Notes

- This slice keeps the batch post-outcome closure artifact transportable
  without flattening nested apply-decision settlement records.
