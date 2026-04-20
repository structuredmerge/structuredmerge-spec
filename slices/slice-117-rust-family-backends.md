## Slice 117: Rust Family Backends

Define multiple parser backends for the same Rust family contract.

### Why

- `rust-merge` should validate the family-backend pattern beyond the stronger native cases
- `syn` is the clearest stable parser-backed native path for Rust in this workspace

### Rules

1. `rust-merge` exposes at least two backends:
   - `tree-sitter`
   - `native`
2. both backends target the same family-facing owner, match, and merge contract
3. backend identity may be observable in feature or conformance reporting
4. backend choice must not silently change the declared family semantics

### Notes

- `native` in this slice means the stable host-language parser path, not necessarily the compiler parser itself
- this slice extends the family-backend pattern to a third source-language family
