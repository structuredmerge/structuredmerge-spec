## Slice 395: Template Directory Session Entrypoint Transport Envelope

Export and import a versioned top-level transport envelope for session
entrypoints.

Goals:
- define a transport-safe wrapper for the session entrypoint object from slices
  373 and 374
- preserve the direct entrypoint shape without changing payload-vs-request
  semantics
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session entrypoint may be wrapped in a JSON envelope with a stable `kind`
   and `version`
2. exporting and then importing the envelope yields the original entrypoint
3. the enclosed payload or request is unchanged by transport wrapping

Fixture:
- `template-directory-session-entrypoint-envelope.json`
