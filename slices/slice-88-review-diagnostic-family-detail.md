## Slice 88: Review Diagnostic Family Detail

Expose expected/provided family names on family-mismatch review diagnostics.

### Why

- reason `family_mismatch` identifies the class of failure
- hosts still benefit from explicit structured values for what was expected and
  what was actually provided
- consumers should not parse family names back out of prose

### Rules

1. review decision diagnostics may expose `expected_family`
2. review decision diagnostics may expose `provided_family`
3. when `reason` is `family_mismatch`, both fields should be present
4. the human-readable message remains required

### Notes

- this slice only applies to diagnostics where family mismatch is the known
  reason
- it does not require unrelated diagnostics to expose family detail fields
