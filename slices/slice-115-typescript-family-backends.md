## Slice 115: TypeScript Family Backends

Define the substrate backend contract for the TypeScript family package.

### Why

- `typescript-merge` now follows the same substrate-first shape as the other
  family packages
- native TypeScript parser behavior still matters, but it belongs in a provider
  package rather than the family package

### Rules

1. `typescript-merge` exposes exactly one substrate backend:
   - `kreuzberg-language-pack`
2. the family package keeps the shared TypeScript owner, match, and merge
   contract
3. non-tree-sitter TypeScript parsers MAY be exposed by separate provider
   packages
4. provider identity remains visible through provider-local feature profiles,
   contexts, plans, and reports rather than through the family package

### Notes

- backend-limited behavior may still surface through conformance selection
- this slice now defines the family substrate boundary, not provider plurality
