`markdown-merge` MUST reject reviewed nested review artifacts that do not carry
a reviewed nested execution payload for `markdown`.

The entrypoints that consume replay bundles and review state MUST:

1. detect when no reviewed nested execution payload for `markdown` is present
2. return `ok: false`
3. emit one `configuration_error` diagnostic

Fixture:
- `fenced-code-reviewed-nested-review-artifact-rejection.json`
