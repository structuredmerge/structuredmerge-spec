## Slice 344: Mini Template Tree Run Report

`ast-merge` MUST provide a shared helper that reports a miniature template tree
run as stable, ordered write intents.

Given:

1. a `template_tree_run` result,

the helper MUST return:

1. ordered `entries`,
2. a `summary`.

Each report entry MUST include:

1. `template_source_path`,
2. `logical_destination_path`,
3. `destination_path`,
4. `execution_action`,
5. `status`.

`status` MUST be one of:

- `created`
- `updated`
- `kept`
- `blocked`
- `omitted`

The report entry order MUST match the execution plan order.
