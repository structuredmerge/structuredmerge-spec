## Slice 413: Template Directory Session Status Transport Envelope

Export and import a versioned top-level transport envelope for session
status reports.

Goals:
- define a transport-safe wrapper for the stable session status object from
  slice 358
- preserve the full top-level status shape across plan and registry-backed
  execution modes
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session status report may be wrapped in a JSON envelope with a stable
   `kind` and `version`
2. exporting and then importing the envelope yields the original status
   report
3. the enclosed mode, readiness, missing-family, blocked-path, and write-count
   fields are unchanged by transport wrapping

Fixture:
- `template-directory-session-status-envelope.json`
