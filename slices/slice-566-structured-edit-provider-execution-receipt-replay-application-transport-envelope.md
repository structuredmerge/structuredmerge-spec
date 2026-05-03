# Slice 566: Structured Edit Provider Execution Receipt Replay Application Transport Envelope

## Goal

Standardize a transport envelope for one provider execution receipt replay
application.

## Shared Behavior

This slice defines one shared receipt replay-application envelope:

1. exporting a replay application yields an envelope with a stable `kind`,
2. the envelope `kind` is
   `structured_edit_provider_execution_receipt_replay_application`,
3. the envelope payload carries one shared receipt replay-application record.

## Notes

- This slice standardizes transport, not replay-application interpretation
  rules.
