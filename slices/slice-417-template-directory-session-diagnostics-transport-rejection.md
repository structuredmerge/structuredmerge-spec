## Slice 417: Template Directory Session Diagnostics Transport Rejection

Reject unsupported session-diagnostics transport envelopes.

Goals:
- keep the session-diagnostics transport boundary strict
- reject envelopes whose top-level `kind` is not the session-diagnostics kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session-diagnostics envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session-diagnostics envelope with an unsupported `version`
   fails with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported diagnostics report

Fixture:
- `template-directory-session-diagnostics-envelope-rejection.json`
