## Slice 274: TypeScript Provider Plan Contexts

Normalize non-tree-sitter provider plan contexts for the TypeScript family.

### Why

- planning should preserve TypeScript family identity while making provider
  choice explicit
- provider contexts should align with the substrate-first family structure

### Rules

1. each TypeScript provider exposes the shared TypeScript family profile
2. each provider plan context reports its own backend identity
3. provider plan contexts keep the same family-facing structure as the
   TypeScript substrate

### Notes

- the first provider context is the TypeScript compiler-backed provider context
