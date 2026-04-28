## Slice 387: Template Directory Session Invocation Transport Rejection

Reject session-invocation transport envelopes whose identity does not match the
supported contract.

Goals:
- reject wrong transport kinds
- reject unsupported transport versions
- preserve the hard edge around invocation payload identity

This slice defines one narrow rejection contract:

1. importing session-invocation transport requires the expected envelope kind
2. importing session-invocation transport requires supported version `1`
3. wrong kind emits an explicit `kind_mismatch` rejection
4. wrong version emits an explicit `unsupported_version` rejection

Fixture:
- `template-directory-session-invocation-envelope-rejection.json`
