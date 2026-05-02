# Slice 541: Structured Edit Provider Execution Run Result

## Goal

Standardize the shared result shape for one runnable provider execution
invocation.

## Shared Behavior

This slice defines one shared execution run-result contract:

1. the run result carries one shared provider execution-invocation record,
2. the run result carries one shared provider execution-outcome record,
3. run-result metadata may remain visible without changing either nested
   execution object.

## Notes

- This slice standardizes the post-invocation result shape, not executor
  implementation details.
