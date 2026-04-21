# Slice 270: TOML Provider Plan Contexts

## Goal

Normalize non-tree-sitter provider plan contexts for the TOML family.

## Shared Behavior

This slice defines one TOML provider plan-context contract:

1. each TOML provider exposes the shared TOML family profile,
2. each provider plan context reports its own backend identity,
3. provider plan contexts keep the same family-facing structure as the TOML
   substrate plan context.
