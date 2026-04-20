## Slice 87: Review Diagnostic Payload Kind

Expose required payload kind on review diagnostics for missing-payload failures.

### Why

- action offers tell a host what a request can accept
- invalid decisions still need to say what payload kind was missing
- hosts should not infer required payload shape from prose or only from action
  names

### Rules

1. review decision diagnostics may expose `payload_kind`
2. when `reason` is `missing_required_payload`, `payload_kind` identifies the
   required payload shape
3. the current `provide_explicit_context` review action reports payload kind
   `conformance_family_context`
4. `payload_kind` supplements, but does not replace, the human-readable message

### Notes

- this slice does not require all review diagnostics to expose payload kinds
- it applies only where missing payload is the reason for rejection
