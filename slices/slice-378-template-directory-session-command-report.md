## Slice 378 - Template Directory Session Command Report

`ast-template` MUST provide one product-facing session command helper above the session dispatch helper.

Given:
- a session `command` object containing:
  - `operation`
  - optional `payload`
  - optional `request`
- optional `profiles`

The command helper MUST:
1. accept the same `payload` and `request` shapes already supported by the session entrypoint,
2. normalize the command into the session entrypoint shape internally,
3. route execution through the session dispatch helper from slice 377, and
4. return the same stable dispatch report shape.

The canonical fixture is `fixtures/diagnostics/slice-378-template-directory-session-command-report/template-directory-session-command-report.json`.
