# Slice 196: Markdown Family Plan Contexts

## Goal

Expose backend-specific conformance plan contexts for the Markdown family.

## Shared Behavior

This slice defines one Markdown planning contract:

1. each backend MAY export a Markdown family plan context,
2. the family profile remains stable across backends,
3. the feature profile reports the active backend and whether that backend
   supports dialect selection.

## Notes

- Tree-sitter-backed Markdown planning is expected to report
  `supports_dialects = false`.
