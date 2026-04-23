## Slice 379 - Template Directory Session Command Payload Report

`ast-template` MUST provide one flat session command-payload helper above the session command helper.

Given one command payload containing:
- `operation`
- the same product-facing session runner payload fields already supported by slice 371

The command-payload helper MUST:
1. normalize the command payload into a session command,
2. place the normalized session runner payload under the command `payload` field,
3. preserve the requested `operation`, and
4. return the same stable dispatch report shape from slice 377.

The canonical fixture is `fixtures/diagnostics/slice-379-template-directory-session-command-payload-report/template-directory-session-command-payload-report.json`.
