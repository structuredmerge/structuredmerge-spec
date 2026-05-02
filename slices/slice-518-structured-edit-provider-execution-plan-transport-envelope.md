# Slice 518: Structured Edit Provider Execution Plan Transport Envelope

## Goal

Standardize a versioned transport envelope for a provider execution-plan
record.

## Shared Behavior

This slice defines one shared transport-envelope contract:

1. the envelope `kind` is `structured_edit_provider_execution_plan`,
2. the envelope `version` is `1`,
3. the envelope carries one `execution_plan` payload compatible with slice 517.

## Notes

- This slice standardizes transport shape, not dispatch behavior.
