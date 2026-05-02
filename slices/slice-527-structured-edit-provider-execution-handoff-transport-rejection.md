# Slice 527: Structured Edit Provider Execution Handoff Transport Rejection

## Goal

Standardize rejection semantics when importing an invalid provider
execution-handoff transport envelope.

## Shared Behavior

This slice defines one shared rejection contract:

1. importing an envelope with the wrong `kind` MUST return a kind-mismatch
   error,
2. importing an envelope with an unsupported `version` MUST return an
   unsupported-version error,
3. rejection MUST happen before any provider execution-handoff payload is
   returned.

## Notes

- This slice standardizes rejection semantics, not executor behavior.
