## Slice 279: YAML Provider Named Suite Plans

## Goal

Allow YAML provider packages to participate in named-suite planning.

## Shared Behavior

This slice defines one YAML provider named-suite planning contract:

1. a YAML provider MAY supply the family context used to plan the shared YAML
   suites,
2. provider-backed named-suite planning keeps the same YAML family roles and
   fixture paths as the substrate,
3. provider identity remains visible through the resulting feature profile.

## Notes

- the first TypeScript YAML provider planning contract is `js-yaml`
