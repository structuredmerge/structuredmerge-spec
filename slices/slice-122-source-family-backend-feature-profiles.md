## Slice 122: Source Family Backend Feature Profiles

Define backend-specific feature-profile exporters for multi-backend
source-language families.

### Why

- `typescript-merge`, `rust-merge`, and `go-merge` now support multiple backends
- conformance and planning callers should not have to hand-assemble backend feature views

### Rules

1. a multi-backend source family may export a backend-specific feature profile view
2. the exported view must use the observable backend identity string used by conformance selection
3. the exported view must preserve the family-supported policy surface for that backend unless a narrower support boundary is explicitly declared

### Notes

- this slice is family-layer reporting, not parser-adapter reporting
- backend feature profiles complement, rather than replace, the family feature profile
