# Slice 420: Structured Edit Selection Profile

## Goal

Expose the portable selection-profile contract for structured-edit selectors.

## Shared Behavior

This slice defines one structured-edit selection-profile contract:

1. a selection profile carries one `owner_scope`,
2. it carries the selected `owner_selector` and `owner_selector_family`,
3. it identifies the selector kind as `selector_kind`,
4. it identifies the selection intent as `selection_intent`,
5. it reports `selection_intent_family` and `known_selection_intent`,
6. it may carry one optional `comment_region`,
7. it reports whether trailing-gap extension is requested,
8. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice standardizes selector intent, not selector execution.
- Provider packages remain free to discover owners in backend-specific ways so
  long as they project this shared profile shape.
