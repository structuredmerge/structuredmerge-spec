## Slice 282: Go Provider Plan Contexts

Normalize non-tree-sitter provider plan contexts for the Go family.

### Why

- planning should preserve Go family identity while making provider choice
  explicit
- provider contexts should align with the substrate-first Go family structure

### Rules

1. each Go provider exposes the shared Go family profile
2. each provider plan context reports its own backend identity
3. provider plan contexts keep the same family-facing structure as the Go
   substrate

### Notes

- the first provider context is the `go-parser`-backed provider context
