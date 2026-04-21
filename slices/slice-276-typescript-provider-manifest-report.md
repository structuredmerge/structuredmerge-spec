## Slice 276: TypeScript Provider Manifest Report

Allow TypeScript provider packages to produce manifest-wide reports for the
shared TypeScript suite descriptors.

### Why

- provider-backed execution should report against the shared TypeScript family
  manifest
- provider identity belongs in execution context and reporting, not suite
  identity

### Rules

1. a TypeScript provider MAY execute the shared TypeScript suite manifest
2. provider-backed suite reports keep the same TypeScript family identity and
   case references as the substrate
3. provider identity remains visible through the planned run contexts rather
   than through renamed suites

### Notes

- the first provider report contract is the TypeScript compiler-backed provider
  contract
