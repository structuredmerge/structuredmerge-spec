# Slice 478: Structured Edit Provider Execution Outcome Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider-execution
outcome contract.

## Shared Behavior

This slice defines one shared execution-outcome transport envelope:

1. the envelope kind is `structured_edit_provider_execution_outcome`,
2. the envelope version is `1`,
3. the envelope payload is carried under `provider_execution_outcome`.

## Notes

- This slice standardizes transport only, not outcome rejection or application.
