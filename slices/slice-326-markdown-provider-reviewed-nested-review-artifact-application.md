## Slice 326: Markdown Provider Reviewed Nested Review Artifact Application

Native Markdown provider packages MUST provide reviewed nested-merge entrypoints
that consume:

- parent template Markdown source,
- parent destination Markdown source,
- Markdown dialect,
- and either:
  - one replay bundle carrying a reviewed nested execution payload for
    `markdown`, or
  - one review state carrying a reviewed nested execution payload for
    `markdown`.

The provider entrypoints MUST:

1. preserve the shared Markdown reviewed nested review-artifact contract
2. execute the reviewed nested payload through the provider-backed Markdown
   merge entrypoint
3. return the same final reconstructed parent Markdown output as the equivalent
   shared Markdown family entrypoint

Notes:

- Expected first providers:
  - TypeScript: `markdown-it-merge`
  - Rust: `pulldown-cmark-merge`
  - Go: `goldmarkmerge`
  - Ruby: `kramdown-merge`, `commonmarker-merge`, `markly-merge`

Fixtures:
- `typescript-markdown-provider-reviewed-nested-review-artifact-application.json`
- `rust-markdown-provider-reviewed-nested-review-artifact-application.json`
- `go-markdown-provider-reviewed-nested-review-artifact-application.json`
- `ruby-markdown-provider-reviewed-nested-review-artifact-application.json`
