# Slice 172: YAML Family Backend Plan Contexts

## Goal

Lift YAML backend plurality into conformance family plan contexts.

## Shared Behavior

This slice defines one YAML plan-context contract:

1. each YAML backend-specific feature profile MAY be wrapped in a family plan
   context,
2. the family profile remains stable across YAML backends,
3. only the backend-specific feature profile varies between those contexts.

## Notes

- This keeps YAML backend plurality compatible with the existing manifest and
  named-suite planning helpers.
