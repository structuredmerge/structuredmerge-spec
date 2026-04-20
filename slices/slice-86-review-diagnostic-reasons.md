## Slice 86: Review Diagnostic Reasons

Add machine-readable reason codes to review decision diagnostics.

### Why

- request/action identity is useful but not sufficient
- hosts still should not parse prose to distinguish known failure classes
- the current review seam already has stable failure modes worth naming

### Rules

1. review decision diagnostics may expose `reason`
2. missing explicit payload uses reason `missing_required_payload`
3. explicit-context family mismatch uses reason `family_mismatch`
4. stale or non-matching replayed decision uses reason `request_not_found`
5. `reason` supplements the human-readable message; it does not replace it

### Notes

- this slice is intentionally narrow to already-observed review failure modes
- the reason space may grow later, but hosts should only rely on declared codes
