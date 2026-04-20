## Slice 115: TypeScript Family Backends

Define multiple parser backends for the same TypeScript family contract.

### Why

- `typescript-merge` should validate the family-backend pattern beyond Go
- the TypeScript compiler API is the clearest native parser for this family

### Rules

1. `typescript-merge` exposes at least two backends:
   - `tree-sitter`
   - `native`
2. both backends target the same family-facing owner, match, and merge contract
3. backend identity may be observable in feature or conformance reporting
4. backend choice must not silently change the declared family semantics

### Notes

- backend-limited behavior may still surface through conformance selection
- this slice extends the family-backend pattern to a second source-language family
