## Slice 283: Go Provider Named-Suite Plans

Allow Go provider packages to participate in named-suite planning.

### Why

- the shared Go suite descriptors should be executable through provider-local
  contexts
- provider planning should not mutate Go suite identity

### Rules

1. a Go provider MAY supply the family context used to plan the shared Go
   suites
2. provider-backed named-suite planning keeps the same Go family roles and
   fixture paths as the substrate
3. provider identity remains visible through the resulting feature profile

### Notes

- the first provider planning contract is the `go-parser`-backed provider
  contract
