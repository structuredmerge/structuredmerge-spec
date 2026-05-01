# Slice 486: Structured Edit Provider Execution Provenance Transport Envelope

## Goal

Standardize a versioned transport envelope for the shared provider execution
provenance contract.

## Shared Behavior

This slice defines one shared provenance transport envelope:

1. the envelope kind is `structured_edit_provider_execution_provenance`,
2. the envelope version is `1`,
3. the envelope payload is carried under `provenance`.

## Notes

- This slice standardizes transport only, not provenance rejection or replay.
