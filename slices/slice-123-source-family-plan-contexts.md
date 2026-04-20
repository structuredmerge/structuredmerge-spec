## Slice 123: Source Family Plan Contexts

Define backend-specific plan-context exporters for multi-backend source
families.

### Why

- callers still need to pair family and backend feature profiles manually
- multi-backend source families can package that normalized context directly

### Rules

1. a multi-backend source family may export a backend-specific plan context
2. the plan context combines the family feature profile with the selected backend feature profile
3. the plan context must be ready for direct use by conformance planning without additional normalization

### Notes

- this slice is a convenience/export surface, not a new planning rule
