## Slice 383 - Template Directory Session Invocation Report

`ast-template` MUST provide one top-level session invocation helper above the
session command and session command-payload helpers.

Given one session invocation object containing:

- `operation`
- optional nested `payload`
- optional nested `request`
- optional flat session command-payload fields from slice 379

The invocation helper MUST:

1. accept the same nested command shape supported by slice 378,
2. accept the same flat command-payload shape supported by slice 379,
3. when nested `payload` or `request` is present, route through the session
   command helper,
4. otherwise route through the session command-payload helper, and
5. return the same stable dispatch report shape from slice 377.

The canonical fixture is `fixtures/diagnostics/slice-383-template-directory-session-invocation-report/template-directory-session-invocation-report.json`.
