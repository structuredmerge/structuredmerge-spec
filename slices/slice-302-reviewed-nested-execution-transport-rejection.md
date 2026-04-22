## Slice 302: Reviewed Nested Execution Transport Rejection

Reject reviewed nested execution transport envelopes whose identity does not
match the supported contract.

Goals:
- reject wrong transport kinds
- reject unsupported transport versions
- avoid best-effort reuse of mismatched nested execution payloads

This slice defines one narrow rejection contract:

1. importing reviewed nested execution transport requires the expected envelope
   kind
2. importing reviewed nested execution transport requires supported version `1`
3. wrong kind emits an explicit `kind_mismatch` rejection
4. wrong version emits an explicit `unsupported_version` rejection

Fixture:
- `reviewed-nested-execution-envelope-rejection.json`
