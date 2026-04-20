## Slice 113: Go Family Backends

Define multiple parser backends for the same Go family contract.

### Why

- the Ruby family stacks were strongest when one family contract supported multiple parsers
- `go-merge` is the cleanest first test of that pattern
- backend plurality should be a family concern, not just a `tree-haver` experiment

### Rules

1. `go-merge` exposes at least two backends:
   - `tree-sitter`
   - `native`
2. both backends target the same family-facing owner, match, and merge contract
3. backend identity may be observable in feature or conformance reporting
4. backend choice must not silently change the declared family semantics

### Notes

- backend-limited behavior may still surface through conformance selection
- this slice defines the family-backend pattern, not full parity for every language family
