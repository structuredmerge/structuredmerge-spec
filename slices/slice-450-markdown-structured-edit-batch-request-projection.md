# Slice 450: Markdown Structured Edit Batch Request Projection

## Goal

Project the shared structured-edit batch-request contract onto the Markdown
provider surface.

## Shared Behavior

This slice defines one Markdown batch-request projection contract:

1. the Markdown provider may expose the shared structured-edit batch-request
   shape,
2. the projection remains compatible with shared request vocabulary and ordered
   batch semantics,
3. provider-local metadata may remain visible without changing the shared
   batch-request contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice standardizes batch-request projection, not batch execution.
