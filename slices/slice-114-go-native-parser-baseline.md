## Slice 114: Go Parser Provider Baseline

Define the baseline `go-parser` provider path for Go in Go.

### Why

- `go/parser` is the clearest first example of a native Go parser living beside
  tree-sitter
- the Go family package is substrate-first, so the native parser needs a
  provider package contract of its own

### Rules

1. the `go-parser` backend uses Go's standard parser stack
2. the `go-parser` backend is exposed by a discrete provider package rather than
   by `go-merge`
3. the provider exposes the same Go family-facing owner paths and merge
   behavior as the tree-sitter substrate for the covered fixtures
4. backend choice is explicit and stable
5. when snippet fixtures omit a package clause, the provider may inject a
   synthetic package header so long as exposed spans and rendered text are
   remapped to the original source

### Notes

- deeper backend-comparison coverage can grow later
- this slice focuses on the first provider parity subset, not full backend
  equivalence
