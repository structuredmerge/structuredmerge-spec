# Slice 519: Structured Edit Provider Execution Plan Transport Rejection

## Goal

Standardize import rejection for invalid provider execution-plan transport
envelopes.

## Shared Behavior

This slice defines one shared import-rejection contract:

1. envelopes with the wrong `kind` are rejected,
2. envelopes with an unsupported `version` are rejected,
3. successful imports remain governed by slice 518.

## Notes

- This slice standardizes rejection semantics, not execution planning logic.
