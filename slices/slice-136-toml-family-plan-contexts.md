# Slice 136: TOML Family Plan Contexts

## Goal

Lift TOML backend plurality into conformance family plan contexts.

## Shared Behavior

This slice defines one TOML plan-context contract:

1. each TOML backend-specific feature profile MAY be wrapped in a family plan
   context,
2. the family profile remains stable across TOML backends,
3. only the backend-specific feature profile varies between those contexts.

## Notes

- This keeps TOML backend plurality compatible with the existing manifest and
  named-suite planning helpers.
