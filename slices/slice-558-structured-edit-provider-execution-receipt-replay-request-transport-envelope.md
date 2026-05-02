# Slice 558: Structured Edit Provider Execution Receipt Replay Request Transport Envelope

## Goal

Standardize a versioned transport envelope for one shared provider execution
receipt replay request.

## Shared Behavior

This slice defines one shared receipt replay-request envelope:

1. the envelope kind is
   `structured_edit_provider_execution_receipt_replay_request`,
2. the envelope version is explicit and shared across implementations,
3. the envelope payload carries one shared receipt replay request.

## Notes

- This slice standardizes transport, not replay policy semantics.
