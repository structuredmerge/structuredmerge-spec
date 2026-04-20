# Slice 206: Markdown Provider Named-Suite Plans

## Goal

Allow native Markdown provider packages to participate in named-suite planning.

## Shared Behavior

This slice defines one provider planning contract:

1. a native Markdown provider MAY supply the family context used to plan the
   shared Markdown named suites,
2. the resulting plan preserves the same family roles and fixture paths as the
   substrate-driven Markdown family plan,
3. provider identity remains visible through the resulting feature profile.
