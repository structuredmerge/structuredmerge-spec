## Slice 327: Markdown Provider Reviewed Nested Review Artifact Rejection

Native Markdown provider packages MUST reject reviewed nested review artifacts
that do not carry a reviewed nested execution payload for `markdown`.

The provider entrypoints that consume replay bundles and review state MUST:

1. detect when no reviewed nested execution payload for `markdown` is present
2. return `ok: false`
3. emit one `configuration_error` diagnostic matching the shared Markdown
   family rejection

Notes:

- Expected first providers:
  - TypeScript: `markdown-it-merge`
  - Rust: `pulldown-cmark-merge`
  - Go: `goldmarkmerge`
  - Ruby: `kramdown-merge`, `commonmarker-merge`, `markly-merge`

Fixtures:
- `typescript-markdown-provider-reviewed-nested-review-artifact-rejection.json`
- `rust-markdown-provider-reviewed-nested-review-artifact-rejection.json`
- `go-markdown-provider-reviewed-nested-review-artifact-rejection.json`
- `ruby-markdown-provider-reviewed-nested-review-artifact-rejection.json`
