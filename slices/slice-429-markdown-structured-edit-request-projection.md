# Slice 429: Markdown Structured Edit Request Projection

## Goal

Project the shared structured-edit request contract onto the Markdown provider
surface.

## Shared Behavior

This slice defines one Markdown request-projection contract:

1. the Markdown provider may expose the shared structured-edit request shape,
2. the projection remains compatible with the shared operation and selector
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   request contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice preserves provider differences such as section-owned destinations
  without changing the shared request shape.
