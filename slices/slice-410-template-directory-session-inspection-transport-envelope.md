## Slice 410: Template Directory Session Inspection Transport Envelope

Export and import a versioned top-level transport envelope for session
inspection reports.

Goals:
- define a transport-safe wrapper for the stable session inspection object from
  slice 376
- preserve the full top-level inspection shape across payload- and
  request-driven inspection flows
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session inspection report may be wrapped in a JSON envelope with a stable
   `kind` and `version`
2. exporting and then importing the envelope yields the original inspection
   report
3. the enclosed entrypoint report, session resolution, adapter capabilities,
   status, and diagnostics are unchanged by transport wrapping

Fixture:
- `template-directory-session-inspection-envelope.json`
