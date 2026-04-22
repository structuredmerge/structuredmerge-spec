## Slice 338: Template Execution Plan

`ast-merge` MUST provide a shared helper that turns prepared template entries
into an ordered dry-run execution plan.

Given:

1. an ordered prepared template entry list,
2. destination content keyed by `destination_path`,

the helper MUST return one execution entry per prepared template entry with:

1. `execution_action`
2. `ready`
3. `destination_content`

The `execution_action` rules MUST be:

- `blocked` when the prepared entry is blocked,
- `omit` when the prepared entry has no destination path,
- `keep` when `write_action` is `keep`,
- `raw_copy` when the selected strategy is `raw_copy`,
- `write_prepared_content` when the selected strategy is `accept_template`,
- `merge_prepared_content` when the selected strategy is `merge`.

`ready` MUST be `false` only for `blocked`, `omit`, and `keep`. All other
execution actions are ready for a later runner stage.

This slice keeps the execution plan dry-run only: it describes what the runner
would do and what content it would consume, but performs no merge or write.
