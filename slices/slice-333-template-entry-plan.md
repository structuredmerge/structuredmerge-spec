## Slice 333: Template Entry Plan

`ast-merge` MUST provide a shared helper that converts an ordered list of
template source-relative paths into an ordered dry-run template plan.

For each template source path, the planner MUST:

1. normalize the template source path to a logical destination path
2. remap the logical destination path to an actual destination path
3. classify the logical destination path
4. select the effective template strategy
5. derive a final action:
   - `omit` when no destination path is produced
   - otherwise the selected strategy name

The planner MUST preserve the original source entry order and return one plan
entry for each input source path.

This slice does not read the filesystem, inspect destination contents, or
perform token resolution or writes.
