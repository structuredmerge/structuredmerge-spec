## Slice 404: Template Directory Session Request Transport Envelope

Export and import a versioned top-level transport envelope for normalized
session requests.

Goals:
- define a transport-safe wrapper for the normalized session request-report
  object from slice 367
- preserve the direct request-report shape without changing readiness,
  diagnostics, or resolved options
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a normalized session request may be wrapped in a JSON envelope with a stable
   `kind` and `version`
2. exporting and then importing the envelope yields the original request report
3. the enclosed readiness, diagnostics, and resolved options are unchanged by
   transport wrapping

Fixture:
- `template-directory-session-request-envelope.json`
