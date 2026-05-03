# Slice 630: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply-decision record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision transport
contract:

1. exporting a replay-workflow apply decision yields an envelope with a stable
   `kind` and transport `version`,
2. importing that envelope reproduces the same replay-workflow apply-decision
   record.

## Notes

- This slice keeps the first post-apply decision artifact transportable without
  flattening the nested apply-result record.
