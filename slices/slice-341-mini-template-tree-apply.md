## Slice 341: Mini Template Tree Apply

`ast-merge` MUST provide a shared helper that applies a template execution plan
through callback-driven merge execution.

Given:

1. an ordered template execution plan,
2. a merge callback for `merge_prepared_content` entries,

the helper MUST return:

1. `result_files`
2. `created_paths`
3. `updated_paths`
4. `kept_paths`
5. `blocked_paths`
6. `omitted_paths`
7. `diagnostics`

The helper MUST:

- write `prepared_template_content` for `raw_copy` and `write_prepared_content`,
- preserve `destination_content` for `keep`,
- skip `omit`,
- preserve `blocked`,
- invoke the merge callback for every `merge_prepared_content` entry that has a
  destination content,
- use `prepared_template_content` directly for `merge_prepared_content` entries
  whose destination content is absent,
- surface callback diagnostics in the returned `diagnostics`.
