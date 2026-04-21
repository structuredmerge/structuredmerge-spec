# Slice 196: Markdown Family Plan Contexts

## Goal

Expose backend-specific conformance plan contexts for the Markdown family.

## Shared Behavior

This slice defines one Markdown planning contract:

1. `markdown-merge` exports the Markdown family plan context for the built-in tree-sitter backend,
2. the family profile remains stable when native provider packages export their own plan contexts,
3. the feature profile reports the active backend and whether that backend supports dialect selection.

## Notes

- Tree-sitter-backed Markdown planning is expected to report
  `supports_dialects = false`.
- Native provider packages report their own plan contexts separately.
