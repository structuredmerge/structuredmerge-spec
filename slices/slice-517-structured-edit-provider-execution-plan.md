# Slice 517: Structured Edit Provider Execution Plan

## Goal

Standardize a provider-execution plan that binds one routed provider execution
request to one resolved executor selection.

## Shared Behavior

This slice defines one shared execution-plan contract:

1. the plan carries one provider execution request,
2. the plan carries one provider executor resolution,
3. the routed request and selected executor remain visible together without
   flattening the shared executor-resolution contract,
4. metadata may remain visible without changing either underlying payload.

## Notes

- This slice is the bridge between executor resolution and future execution
  dispatch.
- It standardizes plan shape, not dispatch or execution outcome.
