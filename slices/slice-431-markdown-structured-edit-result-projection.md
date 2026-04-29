# Slice 431: Markdown Structured Edit Result Projection

## Goal

Project the shared structured-edit result contract onto the Markdown provider
surface.

## Shared Behavior

This slice defines one Markdown result-projection contract:

1. the Markdown provider may expose the shared structured-edit result shape,
2. the projection remains compatible with shared operation and destination
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   result contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice preserves provider differences such as the absence of
  comment-anchored destination profiles without changing the shared result
  shape.
