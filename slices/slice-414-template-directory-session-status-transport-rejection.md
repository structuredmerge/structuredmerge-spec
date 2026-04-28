## Slice 414: Template Directory Session Status Transport Rejection

Reject unsupported session-status transport envelopes.

Goals:
- keep the session-status transport boundary strict
- reject envelopes whose top-level `kind` is not the session-status kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session-status envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session-status envelope with an unsupported `version` fails
   with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported status report

Fixture:
- `template-directory-session-status-envelope-rejection.json`
