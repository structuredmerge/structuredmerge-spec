# Slice 510: Structured Edit Provider Executor Selection Policy Transport Envelope

## Goal

Standardize a versioned transport envelope for a provider executor-selection
policy.

## Shared Behavior

This slice defines one shared transport-envelope contract:

1. the envelope `kind` is
   `structured_edit_provider_executor_selection_policy`,
2. the envelope `version` is `1`,
3. the envelope carries one `selection_policy` payload compatible with slice
   509.

## Notes

- This slice standardizes transport shape, not selection behavior.
