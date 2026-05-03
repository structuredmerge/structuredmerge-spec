# Slice 646: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Settlement Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply-decision
settlement record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
settlement transport contract:

1. exporting a replay-workflow apply-decision settlement yields an envelope
   with a stable `kind` and transport `version`,
2. importing that envelope reproduces the same replay-workflow apply-decision
   settlement record.

## Notes

- This slice keeps the first post-outcome closure artifact transportable
  without flattening the nested apply-decision outcome record.
