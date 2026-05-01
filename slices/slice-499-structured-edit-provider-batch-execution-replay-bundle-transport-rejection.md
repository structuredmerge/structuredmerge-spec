# Slice 499: Structured Edit Provider Batch Execution Replay Bundle Transport Rejection

## Goal

Standardize import rejection for invalid provider batch execution replay-bundle
transport envelopes.

## Shared Behavior

This slice defines one shared rejection contract:

1. import rejects envelopes whose `kind` is not
   `structured_edit_provider_batch_execution_replay_bundle`,
2. import rejects envelopes whose `version` is not `1`,
3. the rejection reports whether the failure was caused by kind mismatch or
   unsupported version.

## Notes

- This slice standardizes rejection only, not batch replay execution.
