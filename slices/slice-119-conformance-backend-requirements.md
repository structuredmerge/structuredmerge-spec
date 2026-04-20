## Slice 119: Conformance Backend Requirements

Define backend-aware case selection for conformance requirements.

### Why

- source-language families now support multiple backends side by side
- backend-limited cases should be expressed in the same normalized requirement shape as dialect and policy limits

### Rules

1. `ConformanceCaseRequirements` may declare an optional `backend`
2. if a case requires a backend and a different backend is active, selection is skipped with an explicit message
3. backend requirements are evaluated alongside dialect and policy requirements
4. backend requirements must not be silently ignored when a feature profile is present

### Notes

- this slice does not require backend-specific manifest planning yet
- this slice only standardizes backend-aware case selection
