## Slice 353: Template Directory Session Report

`ast-template` MUST provide a stable top-level directory session report shape
above `ast-merge`.

Given:

1. a dry-run planning session over a real miniature template tree,
2. a first apply session over a real miniature template tree, and
3. a second apply session over that already-updated destination tree,

the directory session report helper MUST:

1. require an explicit `mode`,
2. support `plan`, `apply`, and `reapply` modes,
3. include the selected `mode` in the top-level report, and
4. include the existing `ast-merge` directory runner report under a stable
   `runner_report` field without changing its shape.
