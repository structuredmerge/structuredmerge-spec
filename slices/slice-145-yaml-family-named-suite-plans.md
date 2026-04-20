# Slice 145: YAML Family Named-Suite Plans

## Goal

Plan YAML named suites through host-specific family plan contexts.

## Shared Behavior

This slice defines one YAML named-suite planning contract:

1. a YAML named suite MAY be planned through the existing named-suite planning
   helpers,
2. the selected YAML family plan context contributes the host-specific feature
   profile to each planned case run,
3. the suite identity and YAML role order stay stable across hosts.
