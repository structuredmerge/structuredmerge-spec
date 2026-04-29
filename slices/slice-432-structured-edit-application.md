# Slice 432: Structured Edit Application

## Goal

Expose the first portable structured-edit application contract for CRISPR-style
edit execution.

## Shared Behavior

This slice defines one structured-edit application contract:

1. an application carries one `request`,
2. it carries one `result`,
3. the result corresponds to the request `operation_kind`,
4. the request and result remain portable shared-contract objects,
5. implementation metadata may remain visible without changing the portable
   application shape.

## Notes

- This slice is the first shared execution-facing contract built from the
  request and result slices.
- It standardizes request-to-result application shape, not shared runtime
  execution.
