## Slice 402: Template Directory Session Runner Payload Transport Rejection

Reject unsupported session runner-payload transport envelopes.

Goals:
- keep the runner-payload transport boundary strict
- reject envelopes whose top-level `kind` is not the session runner-payload
  kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session runner-payload envelope with the wrong `kind` fails with
   a kind-mismatch transport error
2. importing a session runner-payload envelope with an unsupported `version`
   fails with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported payload

Fixture:
- `template-directory-session-runner-payload-envelope-rejection.json`
