# Slice 606: Structured Edit Provider Execution Receipt Replay Workflow Apply Request Transport Envelope

## Goal

Standardize one transport envelope for a replay-workflow apply request.

## Shared Behavior

This slice defines one shared replay-workflow apply-request transport contract:

1. exporting a replay-workflow apply request yields an envelope with a stable
   `kind` and shared transport `version`,
2. importing the same envelope yields the original shared replay-workflow apply
   request unchanged.

## Notes

- The envelope MUST NOT flatten the nested replay-workflow review-request
  artifact.
