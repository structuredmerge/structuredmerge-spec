## Slice 393: Template Directory Session Command Payload Transport Rejection

Reject session command-payload transport envelopes whose identity does not
match the supported contract.

Goals:
- reject wrong transport kinds
- reject unsupported transport versions
- preserve the hard edge around command-payload identity

This slice defines one narrow rejection contract:

1. importing session command-payload transport requires the expected envelope
   kind
2. importing session command-payload transport requires supported version `1`
3. wrong kind emits an explicit `kind_mismatch` rejection
4. wrong version emits an explicit `unsupported_version` rejection

Fixture:
- `template-directory-session-command-payload-envelope-rejection.json`
