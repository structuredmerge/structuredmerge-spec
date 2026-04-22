`ruby-merge` MUST reject reviewed nested review artifacts that do not carry a
reviewed nested execution payload for `ruby`.

The entrypoints that consume replay bundles and review state MUST:

1. detect when no reviewed nested execution payload for `ruby` is present
2. return `ok: false`
3. emit one `configuration_error` diagnostic

Fixture:
- `yard-example-reviewed-nested-review-artifact-rejection.json`
