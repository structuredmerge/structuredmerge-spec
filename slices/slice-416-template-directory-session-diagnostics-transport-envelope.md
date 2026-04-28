## Slice 416: Template Directory Session Diagnostics Transport Envelope

Export and import a versioned top-level transport envelope for session
diagnostics reports.

Goals:
- define a transport-safe wrapper for the stable session diagnostics object
  from slice 359
- preserve the full top-level diagnostics shape across plan and
  registry-backed execution modes
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session diagnostics report may be wrapped in a JSON envelope with a
   stable `kind` and `version`
2. exporting and then importing the envelope yields the original diagnostics
   report
3. the enclosed mode, readiness, and diagnostic entries are unchanged by
   transport wrapping

Fixture:
- `template-directory-session-diagnostics-envelope.json`
