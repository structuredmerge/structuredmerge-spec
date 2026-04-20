## Slice 76: Review Replay Bundle Transport Rejection

Reject replay-bundle transport envelopes whose identity does not match the
supported contract.

Goals:
- reject wrong transport kinds
- reject unsupported transport versions
- preserve the hard edge around replay payload identity

This slice defines one narrow rejection contract:

1. importing replay-bundle transport requires the expected envelope kind
2. importing replay-bundle transport requires supported version `1`
3. wrong kind emits an explicit `kind_mismatch` rejection
4. wrong version emits an explicit `unsupported_version` rejection

Fixture:
- `review-replay-bundle-envelope-rejection.json`
