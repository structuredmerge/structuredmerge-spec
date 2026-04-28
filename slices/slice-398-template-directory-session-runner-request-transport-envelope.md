## Slice 398: Template Directory Session Runner Request Transport Envelope

Export and import a versioned top-level transport envelope for session runner
requests.

Goals:
- define a transport-safe wrapper for the session runner-request object from
  slice 369
- preserve the direct request shape without changing options-vs-profile
  semantics
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session runner request may be wrapped in a JSON envelope with a stable
   `kind` and `version`
2. exporting and then importing the envelope yields the original request
3. the enclosed options or overrides are unchanged by transport wrapping

Fixture:
- `template-directory-session-runner-request-envelope.json`
