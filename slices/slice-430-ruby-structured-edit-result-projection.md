# Slice 430: Ruby Structured Edit Result Projection

## Goal

Project the shared structured-edit result contract onto the Ruby provider
surface.

## Shared Behavior

This slice defines one Ruby result-projection contract:

1. the Ruby provider may expose the shared structured-edit result shape,
2. the projection remains compatible with shared operation and destination
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   result contract.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes result projection, not shared execution.
