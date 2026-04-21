## Slice 273: TypeScript Provider Feature Profiles

Expose feature profiles for non-tree-sitter TypeScript provider packages.

### Why

- the TypeScript family package is now substrate-first
- the TypeScript compiler parser still needs a host-visible provider contract

### Rules

1. each TypeScript provider package keeps the shared TypeScript family identity
2. each provider package exposes exactly one non-tree-sitter backend identity
3. provider feature profiles remain family-compatible with the TypeScript
   substrate

### Notes

- the first TypeScript provider package is the TypeScript compiler-backed
  provider package
- other hosts may expose different TypeScript providers while preserving the
  same family-facing contract
