## Slice 337: Template Entry Prepared Content

`ast-merge` MUST provide a shared helper that enriches token-aware template plan
entries with prepared template content.

Given:

1. an ordered template entry token-state plan,
2. template source content keyed by `template_source_path`,
3. a token replacement map,

the helper MUST return one enriched entry per plan entry with:

1. `template_content`
2. `prepared_template_content`
3. `preparation_action`

The `preparation_action` rules MUST be:

- `blocked` when the entry is already blocked,
- `resolve_tokens` when token resolution is required and the entry is not blocked,
- `pass_through` otherwise.

When `preparation_action` is `resolve_tokens`, the helper MUST resolve known
token keys in a single pass and leave any still-unknown token text unchanged.

When `preparation_action` is `blocked`, `prepared_template_content` MUST be
`null`.
