## Slice 284: Go Provider Manifest Report

Allow Go provider packages to produce manifest-wide reports for the shared Go
suite descriptors.

### Why

- provider-backed execution should report against the shared Go family manifest
- provider identity belongs in execution context and reporting, not suite
  identity

### Rules

1. a Go provider MAY execute the shared Go suite manifest
2. provider-backed suite reports keep the same Go family identity and case
   references as the substrate
3. provider identity remains visible through the planned run contexts rather
   than through renamed suites

### Notes

- the first provider report contract is the `go-parser`-backed provider
  contract
