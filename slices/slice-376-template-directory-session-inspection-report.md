## Slice 376 - Template Directory Session Inspection Report

The template directory session inspection report MUST provide one final pre-execution envelope above the session entrypoint and session resolution helpers.

The inspection report MUST include:
- `entrypoint_report`
- `session_resolution`
- `adapter_capabilities`
- `status`
- `diagnostics`

The inspection report MUST:
- normalize the entry source through the session entrypoint report
- resolve the session request through the session resolution report
- when the session request is ready, compute default adapter capabilities, dry-run status, and dry-run diagnostics without applying the session
- when the session request is not ready, return empty adapter capabilities and a not-ready status with zero planned or written activity

The canonical fixture is `fixtures/diagnostics/slice-376-template-directory-session-inspection-report/template-directory-session-inspection-report.json`.
