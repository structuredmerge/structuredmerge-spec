## Slice 357: Template Directory Session Envelope Report

`ast-template` MUST provide a stable session envelope that combines the
directory session report with adapter capability reporting.

Given:

1. a dry-run planning session over a real miniature template tree,
2. an apply session with full adapter coverage, and
3. a dry-run or apply session with missing adapter coverage,

the session envelope helper MUST:

1. include the existing session report under `session_report`,
2. include the adapter capability report under `adapter_capabilities`,
3. preserve the stable sub-report shapes without changing them, and
4. make the capability report available for dry-run as well as apply-mode
   responses.
