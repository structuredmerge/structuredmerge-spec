## Slice 116: TypeScript Native Parser Baseline

Define the baseline native-parser path for `typescript-merge` in TypeScript.

### Why

- the TypeScript compiler API is a first-class native parser for the host language
- this slice proves a second family can support native and tree-sitter backends side by side

### Rules

1. the native backend uses the TypeScript compiler API parser
2. the native backend exposes the same family-facing owner paths and merge behavior as the tree-sitter backend for the covered fixtures
3. backend choice is explicit and stable

### Notes

- deeper backend-comparison coverage can grow later
- this slice focuses on the first parity subset, not full backend equivalence
