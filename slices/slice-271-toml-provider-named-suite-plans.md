# Slice 271: TOML Provider Named-Suite Plans

## Goal

Allow TOML provider packages to participate in named-suite planning.

## Shared Behavior

This slice defines one TOML provider planning contract:

1. a TOML provider MAY supply the family context used to plan the shared TOML
   named suites,
2. the resulting plan preserves the same family roles and fixture paths as the
   substrate-driven TOML family plan,
3. provider identity remains visible through the resulting feature profile.
