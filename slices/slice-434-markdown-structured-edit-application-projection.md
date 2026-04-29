# Slice 434: Markdown Structured Edit Application Projection

## Goal

Project the shared structured-edit application contract onto the Markdown
provider surface.

## Shared Behavior

This slice defines one Markdown application-projection contract:

1. the Markdown provider may expose the shared structured-edit application
   shape,
2. the projection remains compatible with shared request and result
   vocabulary,
3. provider-local metadata may remain visible without changing the shared
   application contract.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice preserves provider differences such as section-owned destinations
  without changing the shared application shape.
