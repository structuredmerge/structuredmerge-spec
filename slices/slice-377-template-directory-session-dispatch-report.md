## Slice 377 - Template Directory Session Dispatch Report

`ast-template` MUST provide one top-level session dispatch helper above the inspection and entrypoint-execution helpers.

Given:
- an `operation`
- a session `entrypoint`
- optional `profiles`

The dispatch helper MUST:
1. accept `inspect` and `run` operations,
2. route `inspect` through the pre-execution inspection helper from slice 376,
3. route `run` through the entrypoint outcome helper from slice 373,
4. return one stable envelope containing:
   - `operation`
   - `inspection`
   - `outcome`
5. populate only the branch selected by `operation`, leaving the other branch `null`.

The canonical fixture is `fixtures/diagnostics/slice-377-template-directory-session-dispatch-report/template-directory-session-dispatch-report.json`.
