## Slice 275: TypeScript Provider Named-Suite Plans

Allow TypeScript provider packages to participate in named-suite planning.

### Why

- the shared TypeScript suite descriptors should be executable through
  provider-local contexts
- provider planning should not mutate TypeScript suite identity

### Rules

1. a TypeScript provider MAY supply the family context used to plan the shared
   TypeScript suites
2. provider-backed named-suite planning keeps the same TypeScript family roles
   and fixture paths as the substrate
3. provider identity remains visible through the resulting feature profile

### Notes

- the first provider planning contract is the TypeScript compiler-backed
  provider contract
