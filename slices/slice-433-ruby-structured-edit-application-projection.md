# Slice 433: Ruby Structured Edit Application Projection

## Goal

Project the shared structured-edit application contract onto the Ruby provider
surface.

## Shared Behavior

This slice defines one Ruby application-projection contract:

1. the Ruby provider may expose the shared structured-edit application shape,
2. the projection remains compatible with shared request and result
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   application contract.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes application projection, not a shared executor.
