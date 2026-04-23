## Slice 352: Mini Template Tree Directory Runner Report

`ast-merge` MUST provide one stable top-level directory runner report shape for
template application workflows.

Given:

1. a dry-run directory-backed plan over a real miniature template tree, and
2. an apply-run directory-backed execution over a real miniature template tree,

the directory runner report helper MUST:

1. always include a `plan_report`,
2. include a `preview` only when deterministic preview data is available from
   the execution plan,
3. include a `run_report` and `apply_report` only when an execution result is
   present, and
4. preserve the existing stable sub-report shapes without re-deriving them in a
   product wrapper.
