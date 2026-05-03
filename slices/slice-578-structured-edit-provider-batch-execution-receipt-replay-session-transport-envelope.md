# Slice 578: Structured Edit Provider Batch Execution Receipt Replay Session Transport Envelope

## Goal

Standardize a transport envelope for one batch provider execution receipt
replay-session record.

## Shared Behavior

This slice defines one shared batch replay-session envelope:

1. exporting a batch replay session yields an envelope with a stable `kind`,
2. the envelope `kind` is
   `structured_edit_provider_batch_execution_receipt_replay_session`,
3. the envelope payload carries one shared batch replay-session record.

## Notes

- This slice standardizes transport, not batch replay-session interpretation
  rules.
