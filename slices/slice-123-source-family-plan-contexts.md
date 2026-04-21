## Slice 123: Source Family Plan Contexts

Define backend-specific plan-context exporters for source-language family and
provider packages.

### Why

- callers still need to pair family and backend feature profiles manually
- both substrate family packages and provider packages can package that
  normalized context directly

### Rules

1. a source-language family package may export a built-in backend plan context
2. a source-language provider package may export a provider-specific plan
   context that preserves the shared family identity
3. the plan context combines the family feature profile with the selected
   backend feature profile
4. the plan context must be ready for direct use by conformance planning
   without additional normalization

### Notes

- this slice is a convenience/export surface, not a new planning rule
