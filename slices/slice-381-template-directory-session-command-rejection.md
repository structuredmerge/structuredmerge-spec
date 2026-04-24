## Slice 381 - Template Directory Session Command Rejection

`ast-template` MUST reject unsupported session command operations through the
product-facing session command helper.

The session command rejection contract MUST:

1. accept the same command object shape as slice 378,
2. reject any unsupported `operation` before returning a dispatch report, and
3. emit the same stable unsupported-operation message defined by slice 380.

The canonical fixture is `fixtures/diagnostics/slice-381-template-directory-session-command-rejection/template-directory-session-command-rejection.json`.
