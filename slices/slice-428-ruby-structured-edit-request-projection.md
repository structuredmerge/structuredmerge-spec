# Slice 428: Ruby Structured Edit Request Projection

## Goal

Project the shared structured-edit request contract onto the Ruby provider
surface.

## Shared Behavior

This slice defines one Ruby request-projection contract:

1. the Ruby provider may expose the shared structured-edit request shape,
2. the projection remains compatible with the shared operation and selector
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   request contract.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes request projection, not shared execution.
