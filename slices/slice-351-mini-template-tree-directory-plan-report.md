## Slice 351: Mini Template Tree Directory Plan Report

`ast-merge` MUST provide a stable directory-backed dry-run plan report for a
template tree before execution.

Given:

1. a real miniature template tree stored on disk, and
2. a destination tree whose paths exercise omit, block, keep, create, and
   update planning states,

the directory-backed plan report helper MUST:

1. preserve execution-plan order in reported entries,
2. emit one report entry per execution-plan entry,
3. classify each entry as `create`, `update`, `keep`, `blocked`, or `omitted`,
4. include whether each entry is `previewable` without invoking family merges,
   and
5. summarize the total counts for `create`, `update`, `keep`, `blocked`, and
   `omitted`.
