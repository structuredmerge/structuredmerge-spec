## Slice 396: Template Directory Session Entrypoint Transport Rejection

Reject unsupported session entrypoint transport envelopes.

Goals:
- keep the entrypoint transport boundary strict
- reject envelopes whose top-level `kind` is not the session entrypoint kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session entrypoint envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session entrypoint envelope with an unsupported `version` fails
   with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported entrypoint

Fixture:
- `template-directory-session-entrypoint-envelope-rejection.json`
