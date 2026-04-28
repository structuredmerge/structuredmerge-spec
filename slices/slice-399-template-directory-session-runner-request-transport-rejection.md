## Slice 399: Template Directory Session Runner Request Transport Rejection

Reject unsupported session runner-request transport envelopes.

Goals:
- keep the runner-request transport boundary strict
- reject envelopes whose top-level `kind` is not the session runner-request kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session runner-request envelope with the wrong `kind` fails with
   a kind-mismatch transport error
2. importing a session runner-request envelope with an unsupported `version`
   fails with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported request

Fixture:
- `template-directory-session-runner-request-envelope-rejection.json`
