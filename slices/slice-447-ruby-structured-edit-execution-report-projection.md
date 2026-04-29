# Slice 447: Ruby Structured Edit Execution Report Projection

## Goal

Project the shared structured-edit execution-report contract onto the Ruby
provider surface.

## Shared Behavior

This slice defines one Ruby execution-report projection contract:

1. the Ruby provider may expose the shared structured-edit execution-report
   shape,
2. the projection remains compatible with shared application and diagnostics
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   execution-report contract.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes execution-report projection, not batch orchestration.
