## Slice 411: Template Directory Session Inspection Transport Rejection

Reject unsupported session-inspection transport envelopes.

Goals:
- keep the session-inspection transport boundary strict
- reject envelopes whose top-level `kind` is not the session-inspection kind
- reject envelopes whose `version` is unsupported

This slice defines one narrow rejection contract:

1. importing a session-inspection envelope with the wrong `kind` fails with a
   kind-mismatch transport error
2. importing a session-inspection envelope with an unsupported `version` fails
   with an unsupported-version transport error
3. rejected envelopes do not produce a partially imported inspection report

Fixture:
- `template-directory-session-inspection-envelope-rejection.json`
