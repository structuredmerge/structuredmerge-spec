## Slice 956: Ruby Operator Method Signature Merge

Recognize Ruby operator-style method names when matching and inserting direct
methods inside matched class/module declarations.

### Why

- Ruby methods are not limited to identifier-style names
- `def []`, `def []=`, and operator methods are common API surface
- receiver-aware matching from slice 955 needs a complete method signature
  token for these methods too

### Rules

1. direct operator/indexer methods are collected as method entries
2. operator method signatures participate in template/destination matching
3. destination-owned methods preserve their source text
4. template-only operator methods are inserted using normal method placement
   rules
