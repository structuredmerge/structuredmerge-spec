## Slice 113: Go Family Backends

Define the built-in backend surface for the Go family package.

### Why

- the Go family package now follows the substrate-first structure used by the
  other active families
- backend plurality for Go still exists, but it should enter through provider
  packages rather than through the family package itself
- the family contract still needs one explicit built-in backend identity

### Rules

1. `go-merge` exposes exactly one built-in backend:
   - `kreuzberg-language-pack`
2. the Go family package remains responsible for the shared family-facing owner,
   match, and merge contract
3. non-tree-sitter Go parser stacks must be exposed by discrete provider
   packages rather than by `go-merge`
4. backend identity may be observable in feature or conformance reporting
   without changing the declared Go family semantics

### Notes

- provider-backed execution may still surface through conformance selection
- this slice defines the built-in Go family backend surface, not the full Go
  provider matrix
