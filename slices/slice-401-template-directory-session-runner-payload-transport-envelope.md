## Slice 401: Template Directory Session Runner Payload Transport Envelope

Export and import a versioned top-level transport envelope for session runner
payloads.

Goals:
- define a transport-safe wrapper for the session runner-payload object from
  slice 371
- preserve the direct payload shape without changing request-kind inference or
  profile wiring
- make the envelope stable across language implementations

This slice defines one narrow transport contract:

1. a session runner payload may be wrapped in a JSON envelope with a stable
   `kind` and `version`
2. exporting and then importing the envelope yields the original payload
3. the enclosed payload fields are unchanged by transport wrapping

Fixture:
- `template-directory-session-runner-payload-envelope.json`
