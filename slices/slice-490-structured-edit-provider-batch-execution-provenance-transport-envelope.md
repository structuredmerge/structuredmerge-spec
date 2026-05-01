# Slice 490: Structured Edit Provider Batch Execution Provenance Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider batch
execution-provenance contract.

## Shared Behavior

This slice defines one shared batch-provenance transport envelope:

1. the envelope kind is `structured_edit_provider_batch_execution_provenance`,
2. the envelope version is `1`,
3. the envelope payload is carried under `batch_provenance`.

## Notes

- This slice standardizes transport only, not batch provenance rejection or
  replay.
