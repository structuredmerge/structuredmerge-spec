# Slice 139: TOML Family Named-Suite Plans

## Goal

Plan TOML named suites through backend-specific family plan contexts.

## Shared Behavior

This slice defines one TOML named-suite planning contract:

1. a TOML named suite MAY be planned through the existing named-suite planning
   helpers,
2. the selected TOML family plan context contributes the backend-specific
   feature profile to each planned case run,
3. the suite identity and TOML role order stay stable across backends.
