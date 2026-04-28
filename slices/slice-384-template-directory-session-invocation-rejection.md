## Slice 384 - Template Directory Session Invocation Rejection

`ast-template` MUST reject unsupported operations through the top-level session
invocation helper.

The session invocation rejection contract MUST:

1. accept the same hybrid invocation shape as slice 383,
2. reject any unsupported `operation` before returning a dispatch report, and
3. emit the same stable unsupported-operation message defined by slice 380.

The canonical fixture is `fixtures/diagnostics/slice-384-template-directory-session-invocation-rejection/template-directory-session-invocation-rejection.json`.
