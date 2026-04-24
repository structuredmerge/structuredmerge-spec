## Slice 382 - Template Directory Session Command Payload Rejection

`ast-template` MUST reject unsupported session command-payload operations
through the flat session command-payload helper.

The session command-payload rejection contract MUST:

1. accept the same flat command-payload shape as slice 379,
2. reject any unsupported `operation` before returning a dispatch report, and
3. emit the same stable unsupported-operation message defined by slice 380.

The canonical fixture is `fixtures/diagnostics/slice-382-template-directory-session-command-payload-rejection/template-directory-session-command-payload-rejection.json`.
