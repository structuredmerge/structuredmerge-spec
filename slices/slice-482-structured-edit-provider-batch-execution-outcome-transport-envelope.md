# Slice 482: Structured Edit Provider Batch Execution Outcome Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider batch
execution-outcome contract.

## Shared Behavior

This slice defines one shared batch-outcome transport envelope:

1. the envelope kind is `structured_edit_provider_batch_execution_outcome`,
2. the envelope version is `1`,
3. the envelope payload is carried under `batch_outcome`.

## Notes

- This slice standardizes transport only, not batch outcome rejection or
  replay.
