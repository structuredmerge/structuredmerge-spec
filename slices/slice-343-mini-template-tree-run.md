## Slice 343: Mini Template Tree Run

`ast-merge` MUST provide a shared helper that executes a miniature template tree
run from raw template-tree inputs.

Given:

1. ordered template source paths,
2. template contents,
3. destination contents,
4. the same destination remapping context,
5. the same strategy overrides,
6. the same token replacements,
7. a merge callback for `merge_prepared_content` entries,

the helper MUST:

1. produce the ordered template execution plan,
2. apply that plan through the callback-driven merge helper,
3. return both `execution_plan` and `apply_result`.

The returned `execution_plan` MUST match the standalone planning helper, and the
returned `apply_result` MUST match the standalone apply helper for the same
inputs.
