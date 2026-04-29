# Slice 451: Ruby Structured Edit Batch Report Projection

## Goal

Project the shared structured-edit batch-report contract onto the Ruby provider
surface.

## Shared Behavior

This slice defines one Ruby batch-report projection contract:

1. the Ruby provider may expose the shared structured-edit batch-report shape,
2. the projection remains compatible with shared execution-report and batch
   diagnostics vocabulary,
3. provider-local metadata may remain visible without changing the shared
   batch-report contract.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes batch-report projection, not a batch executor.
