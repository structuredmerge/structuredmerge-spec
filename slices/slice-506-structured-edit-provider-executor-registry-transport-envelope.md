# Slice 506: Structured Edit Provider Executor Registry Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider
executor-registry contract.

## Shared Behavior

This slice defines one shared executor-registry transport envelope:

1. the envelope kind is `structured_edit_provider_executor_registry`,
2. the envelope version is `1`,
3. the envelope payload is carried under `executor_registry`.

## Notes

- This slice standardizes transport only, not executor selection.
