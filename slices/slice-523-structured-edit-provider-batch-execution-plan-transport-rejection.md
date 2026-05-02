# Slice 523: Structured Edit Provider Batch Execution Plan Transport Rejection

## Goal

Standardize import rejection for invalid provider batch execution-plan
transport envelopes.

## Shared Behavior

This slice defines one shared import-rejection contract:

1. envelopes with the wrong `kind` are rejected,
2. envelopes with an unsupported `version` are rejected,
3. successful imports remain governed by slice 522.

## Notes

- This slice standardizes rejection semantics, not batch planning logic.
