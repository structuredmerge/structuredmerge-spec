# Slice 139: TOML Family Named-Suite Plans

## Goal

Plan TOML named suites through the substrate family plan context.

## Shared Behavior

This slice defines one TOML substrate planning contract:

1. a TOML named suite MAY be planned through the existing named-suite planning
   helpers,
2. the TOML substrate plan context contributes the tree-sitter backend-specific
   feature profile to each planned case run,
3. provider packages MAY plan the same shared TOML suites through separate
   provider plan contexts without changing suite identity or role order.
