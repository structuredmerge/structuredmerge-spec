## Slice 120: Manifest Backend Requirements

Define manifest-planned propagation of backend-aware case requirements.

### Why

- backend-limited conformance cases must survive manifest planning, not just direct case selection
- multi-backend source families need a normalized way to declare backend-specific fixture roles

### Rules

1. a manifest entry may declare `requirements.backend`
2. planned runs preserve the backend requirement unchanged
3. backend-aware manifest planning does not alter the family-facing path or case identity

### Notes

- this slice proves propagation, not new planning behavior
- backend filtering still happens at case-selection time
