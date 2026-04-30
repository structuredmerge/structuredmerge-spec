# Slice 474: Structured Edit Provider Batch Execution Dispatch Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider batch
execution-dispatch contract.

## Shared Behavior

This slice defines one shared batch-dispatch transport envelope:

1. the envelope kind is `structured_edit_provider_batch_execution_dispatch`,
2. the envelope version is `1`,
3. the envelope payload is carried under `batch_dispatch`.

## Notes

- This slice standardizes transport only, not batch dispatch rejection or
  execution.
