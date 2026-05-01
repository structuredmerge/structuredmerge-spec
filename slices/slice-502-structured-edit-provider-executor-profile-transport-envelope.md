# Slice 502: Structured Edit Provider Executor Profile Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider
executor-profile contract.

## Shared Behavior

This slice defines one shared executor-profile transport envelope:

1. the envelope kind is `structured_edit_provider_executor_profile`,
2. the envelope version is `1`,
3. the envelope payload is carried under `executor_profile`.

## Notes

- This slice standardizes transport only, not executor discovery or dispatch.
