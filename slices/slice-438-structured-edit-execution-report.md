# Slice 438: Structured Edit Execution Report

## Goal

Expose the first portable report contract for one CRISPR-style structured-edit
execution.

## Shared Behavior

This slice defines one structured-edit execution report contract:

1. a report carries one `application`,
2. it carries zero or more shared `diagnostics`,
3. it exposes the provider `family`,
4. it may expose the provider `backend` without changing the shared
   application shape,
5. implementation metadata may remain visible without changing the portable
   report shape.

## Notes

- This slice standardizes a portable execution-facing report, not transport.
- It reuses the shared diagnostic vocabulary instead of introducing a new
  report-local error shape.
