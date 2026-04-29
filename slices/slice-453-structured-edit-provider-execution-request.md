# Slice 453: Structured Edit Provider Execution Request

## Goal

Standardize a provider-routable structured-edit execution request that binds a
shared request payload to an explicit provider family and backend.

## Shared Behavior

This slice defines one shared execution-request contract:

1. the request carries one shared structured-edit request,
2. the request identifies the provider family that should execute it,
3. the request may identify a concrete provider backend when routing must be
   explicit,
4. metadata may remain visible without changing the shared request payload.

## Notes

- This slice is the first shared orchestration step above provider projections.
- It prepares the future CRISPR-style execution surface without hardcoding a
  Ruby-only runner.
