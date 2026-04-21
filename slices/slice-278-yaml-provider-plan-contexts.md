## Slice 278: YAML Provider Plan Contexts

## Goal

Normalize non-tree-sitter provider plan contexts for the YAML family.

## Shared Behavior

This slice defines one YAML provider plan-context contract:

1. each YAML provider exposes the shared YAML family profile,
2. each provider plan context reports its own backend identity,
3. provider plan contexts keep the same family-facing structure as the YAML
   substrate.

## Notes

- the first TypeScript YAML provider context is `js-yaml`
