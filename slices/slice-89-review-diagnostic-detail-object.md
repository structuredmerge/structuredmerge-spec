## Slice 89: Review Diagnostic Detail Object

Move review-specific diagnostic metadata under one nested object.

### Why

- review diagnostics now carry several related structured fields
- continuing to flatten review-only fields grows the generic diagnostic surface
- nested review detail keeps the shared diagnostic contract cleaner and scales
  better

### Rules

1. diagnostics may expose a nested `review` object
2. review-specific metadata such as request identity, action, reason,
   payload-kind, and family details live under `review`
3. diagnostics unrelated to review handling omit the `review` object
4. human-readable diagnostic message remains required

### Notes

- this slice reorganizes structure; it does not remove previously declared
  review metadata
- future review-specific fields should prefer the nested object over new
  top-level diagnostic fields
