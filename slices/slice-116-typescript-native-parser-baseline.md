## Slice 116: TypeScript Native Parser Baseline

Define the baseline native-parser path for a TypeScript provider package.

### Why

- the TypeScript compiler API is a first-class native parser for the host language
- this slice preserves the native baseline while moving it out of the family
  package

### Rules

1. the native backend uses the TypeScript compiler API parser
2. the native backend is exposed by a discrete provider package rather than by
   `typescript-merge`
3. the provider exposes the same family-facing owner paths and merge behavior as
   the tree-sitter substrate for the covered fixtures
4. backend choice is explicit and stable

### Notes

- deeper backend-comparison coverage can grow later
- this slice focuses on the first provider parity subset, not full backend
  equivalence
