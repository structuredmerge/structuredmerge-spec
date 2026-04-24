## Slice 380 - Template Directory Session Dispatch Rejection

`ast-template` session dispatch MUST reject unsupported operations instead of
silently routing them through execution.

The dispatch rejection contract MUST:

1. accept only `inspect` and `run`,
2. reject any other `operation` before inspection or execution begins, and
3. emit one stable error message that includes the rejected operation.

Recommended message form:

- `unsupported template directory session operation: <operation>`

The canonical fixture is `fixtures/diagnostics/slice-380-template-directory-session-dispatch-rejection/template-directory-session-dispatch-rejection.json`.
