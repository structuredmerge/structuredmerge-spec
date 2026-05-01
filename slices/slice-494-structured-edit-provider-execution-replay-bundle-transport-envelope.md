# Slice 494: Structured Edit Provider Execution Replay Bundle Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider execution
replay-bundle contract.

## Shared Behavior

This slice defines one shared replay-bundle transport envelope:

1. the envelope kind is `structured_edit_provider_execution_replay_bundle`,
2. the envelope version is `1`,
3. the envelope payload is carried under `replay_bundle`.

## Notes

- This slice standardizes transport only, not replay rejection or execution.
