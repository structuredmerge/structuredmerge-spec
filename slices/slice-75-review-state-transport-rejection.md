## Slice 75: Review State Transport Rejection

Reject review-state transport envelopes whose identity does not match the
supported contract.

Goals:
- reject wrong transport kinds
- reject unsupported transport versions
- avoid best-effort reuse of mismatched transport payloads

This slice defines one narrow rejection contract:

1. importing review-state transport requires the expected envelope kind
2. importing review-state transport requires supported version `1`
3. wrong kind emits an explicit `kind_mismatch` rejection
4. wrong version emits an explicit `unsupported_version` rejection

Fixture:
- `review-state-envelope-rejection.json`
