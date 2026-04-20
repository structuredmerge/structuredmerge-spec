## Slice 114: Go Native Parser Baseline

Define the baseline native-parser path for `go-merge` in Go.

### Why

- `go/parser` is the clearest first example of a native parser living beside tree-sitter
- this slice turns family-backend plurality into an implemented behavior surface

### Rules

1. the native backend uses Go's standard parser stack
2. the native backend exposes the same family-facing owner paths and merge behavior as the tree-sitter backend for the covered fixtures
3. backend choice is explicit and stable
4. when snippet fixtures omit a package clause, the native backend may inject a synthetic package header so long as exposed spans and rendered text are remapped to the original source

### Notes

- deeper backend-comparison coverage can grow later
- this slice focuses on the first parity subset, not full backend equivalence
