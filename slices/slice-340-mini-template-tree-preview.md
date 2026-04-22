## Slice 340: Mini Template Tree Preview

`ast-merge` MUST provide a shared helper that previews the result of applying a
dry-run template execution plan when every ready execution is deterministic.

For this preview helper:

- `raw_copy` writes `prepared_template_content`,
- `write_prepared_content` writes `prepared_template_content`,
- `merge_prepared_content` writes `prepared_template_content` only when the
  destination content is absent,
- `keep` preserves `destination_content`,
- `omit` and `blocked` do not write output.

The helper MUST return:

1. `result_files`
2. `created_paths`
3. `updated_paths`
4. `kept_paths`
5. `blocked_paths`
6. `omitted_paths`

This slice intentionally limits preview to deterministic cases. Existing-file
family merges remain the responsibility of later family-specific execution
layers.
