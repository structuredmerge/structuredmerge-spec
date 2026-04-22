## Slice 336: Template Entry Token State

`ast-merge` MUST provide a shared helper that enriches a stateful template entry
plan with token-discovery and unresolved-token blocking state.

Given:

1. an ordered template entry plan that already includes destination existence,
2. template source content keyed by `template_source_path`,
3. a token replacement map,

the helper MUST return one enriched entry per planned entry with:

1. `token_keys`
2. `unresolved_token_keys`
3. `token_resolution_required`
4. `blocked`
5. `block_reason`

`token_resolution_required` MUST be `true` only when the entry would write
templated content to the destination surface. This includes `merge` and
`accept_template`, and excludes:

- entries with no destination path,
- `keep_destination`,
- `raw_copy`

An entry MUST be `blocked` with `block_reason: "unresolved_tokens"` when
`token_resolution_required` is `true` and one or more unresolved token keys
remain in the template source content.

This slice preserves unresolved-token guardrails at planning time so a template
runner can refuse unsafe writes before any merge or filesystem mutation begins.
