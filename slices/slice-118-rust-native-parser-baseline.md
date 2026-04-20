## Slice 118: Rust Native Parser Baseline

Define the baseline native-parser path for `rust-merge` in Rust.

### Why

- `syn` provides a stable parser-backed Rust AST for host-language use
- this slice proves the family-backend pattern can survive a non-compiler native parser

### Rules

1. the native backend uses the `syn` parser stack
2. the native backend exposes the same family-facing owner paths and merge behavior as the tree-sitter backend for the covered fixtures
3. backend choice is explicit and stable

### Notes

- deeper backend-comparison coverage can grow later
- this slice focuses on the first parity subset, not full backend equivalence
