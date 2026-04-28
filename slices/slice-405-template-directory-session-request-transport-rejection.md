## Slice 405: Template Directory Session Request Transport Rejection

Reject unsupported normalized session-request transport envelopes.

Goals:
- keep the session-request transport boundary strict
- reject envelopes whose top-level `kind` is not the session-request kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session-request envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session-request envelope with an unsupported `version` fails
   with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported request report

Fixture:
- `template-directory-session-request-envelope-rejection.json`
