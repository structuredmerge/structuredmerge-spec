## Slice 281: Go Provider Feature Profiles

Expose feature profiles for non-tree-sitter Go provider packages.

### Why

- the Go family package is now substrate-first
- the standard-library Go parser still needs a host-visible provider contract

### Rules

1. each Go provider package keeps the shared Go family identity
2. each provider package exposes exactly one non-tree-sitter backend identity
3. provider feature profiles remain family-compatible with the Go substrate

### Notes

- the first Go provider package is the `go-parser`-backed provider package
- other hosts may expose different Go providers while preserving the same
  family-facing contract
