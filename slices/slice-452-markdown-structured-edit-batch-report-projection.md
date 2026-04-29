# Slice 452: Markdown Structured Edit Batch Report Projection

## Goal

Project the shared structured-edit batch-report contract onto the Markdown
provider surface.

## Shared Behavior

This slice defines one Markdown batch-report projection contract:

1. the Markdown provider may expose the shared structured-edit batch-report
   shape,
2. the projection remains compatible with shared execution-report and batch
   diagnostics vocabulary,
3. provider-local metadata may remain visible without changing the shared
   batch-report contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice standardizes batch-report projection, not a batch executor.
