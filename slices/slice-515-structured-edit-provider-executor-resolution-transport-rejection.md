# Slice 515: Structured Edit Provider Executor Resolution Transport Rejection

## Goal

Standardize import rejection for invalid provider executor-resolution transport
envelopes.

## Shared Behavior

This slice defines one shared import-rejection contract:

1. envelopes with the wrong `kind` are rejected,
2. envelopes with an unsupported `version` are rejected,
3. successful imports remain governed by slice 514.

## Notes

- This slice standardizes rejection semantics, not executor resolution logic.
