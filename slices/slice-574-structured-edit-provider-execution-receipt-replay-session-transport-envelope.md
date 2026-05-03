# Slice 574: Structured Edit Provider Execution Receipt Replay Session Transport Envelope

## Goal

Standardize a transport envelope for one provider execution receipt replay
session.

## Shared Behavior

This slice defines one shared receipt replay-session envelope:

1. exporting a replay session yields an envelope with a stable `kind`,
2. the envelope `kind` is
   `structured_edit_provider_execution_receipt_replay_session`,
3. the envelope payload carries one shared receipt replay-session record.

## Notes

- This slice standardizes transport, not replay-session interpretation rules.
