## Slice 122: Source Family Backend Feature Profiles

Define backend-specific feature-profile exporters for source-language family and
provider packages.

### Why

- conformance and planning callers should not have to hand-assemble backend
  feature views
- source-language family packages now default to substrate-first layouts
- provider packages still need a normalized way to expose backend-specific
  feature views

### Rules

1. a source-language family package may export its built-in backend feature
   profile view
2. a source-language provider package may export its provider backend feature
   profile view while preserving the shared family identity
3. the exported view must use the observable backend identity string used by
   conformance selection
4. the exported view must preserve the family-supported policy surface for that
   backend unless a narrower support boundary is explicitly declared

### Notes

- this slice covers normalized reporting for both substrate packages and
  provider packages
- backend feature profiles complement, rather than replace, the family feature
  profile
