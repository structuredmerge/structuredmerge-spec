## Slice 408: Template Directory Session Outcome Transport Rejection

Reject unsupported session-outcome transport envelopes.

Goals:
- keep the session-outcome transport boundary strict
- reject envelopes whose top-level `kind` is not the session-outcome kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session-outcome envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session-outcome envelope with an unsupported `version` fails
   with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported outcome

Fixture:
- `template-directory-session-outcome-envelope-rejection.json`
