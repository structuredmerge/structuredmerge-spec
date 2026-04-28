## Slice 407: Template Directory Session Outcome Transport Envelope

Export and import a versioned top-level transport envelope for session
outcomes.

Goals:
- define a transport-safe wrapper for the stable session outcome object from
  slice 360
- preserve the full top-level outcome shape across plan and registry-backed
  execution modes
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session outcome may be wrapped in a JSON envelope with a stable `kind`
   and `version`
2. exporting and then importing the envelope yields the original outcome
3. the enclosed session report, status, and diagnostics are unchanged by
   transport wrapping

Fixture:
- `template-directory-session-outcome-envelope.json`
