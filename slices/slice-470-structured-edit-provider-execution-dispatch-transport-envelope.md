# Slice 470: Structured Edit Provider Execution Dispatch Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider-execution
dispatch contract.

## Shared Behavior

This slice defines one shared dispatch transport envelope:

1. the envelope kind is `structured_edit_provider_execution_dispatch`,
2. the envelope version is `1`,
3. the envelope payload is carried under `provider_execution_dispatch`.

## Notes

- This slice standardizes transport only, not dispatch rejection or execution.
