# Slice 448: Markdown Structured Edit Execution Report Projection

## Goal

Project the shared structured-edit execution-report contract onto the Markdown
provider surface.

## Shared Behavior

This slice defines one Markdown execution-report projection contract:

1. the Markdown provider may expose the shared structured-edit execution-report
   shape,
2. the projection remains compatible with shared application and diagnostics
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   execution-report contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice standardizes execution-report projection, not batch orchestration.
