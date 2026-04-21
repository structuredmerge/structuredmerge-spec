# Slice 136: TOML Family Plan Contexts

## Goal

Lift the TOML tree-sitter substrate into conformance family plan contexts.

## Shared Behavior

This slice defines one TOML substrate plan-context contract:

1. the TOML family package exposes exactly one substrate plan context,
2. that plan context carries the shared TOML family profile plus the tree-sitter
   backend profile,
3. non-tree-sitter TOML providers expose separate plan contexts without
   changing the family plan-context shape.

## Notes

- This keeps the TOML family manifest stable while provider packages vary the
  backend-specific feature profile externally.
