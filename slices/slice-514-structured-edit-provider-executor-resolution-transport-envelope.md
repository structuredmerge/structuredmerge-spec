# Slice 514: Structured Edit Provider Executor Resolution Transport Envelope

## Goal

Standardize a versioned transport envelope for a provider executor-resolution
record.

## Shared Behavior

This slice defines one shared transport-envelope contract:

1. the envelope `kind` is `structured_edit_provider_executor_resolution`,
2. the envelope `version` is `1`,
3. the envelope carries one `executor_resolution` payload compatible with slice
   513.

## Notes

- This slice standardizes transport shape, not executor dispatch.
