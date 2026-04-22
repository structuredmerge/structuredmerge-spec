## Slice 328: Markdown Provider Reviewed Nested Review Artifact Envelope Application

Native Markdown provider packages MUST provide reviewed nested-merge entrypoints
that consume:

- parent template Markdown source,
- parent destination Markdown source,
- Markdown dialect,
- and either:
  - one replay-bundle transport envelope carrying a replay bundle whose
    reviewed nested executions include `markdown`, or
  - one review-state transport envelope carrying a review state whose reviewed
    nested executions include `markdown`.

The provider entrypoints MUST:

1. import the review artifact transport envelope
2. preserve the shared Markdown reviewed nested review-artifact envelope
   contract
3. execute the reviewed nested payload through the provider-backed Markdown
   merge entrypoint
4. return the same final reconstructed parent Markdown output as the equivalent
   shared Markdown family entrypoint

Notes:

- Expected first providers:
  - TypeScript: `markdown-it-merge`
  - Rust: `pulldown-cmark-merge`
  - Go: `goldmarkmerge`
  - Ruby: `kramdown-merge`, `commonmarker-merge`, `markly-merge`

Fixtures:
- `typescript-markdown-provider-reviewed-nested-review-artifact-envelope-application.json`
- `rust-markdown-provider-reviewed-nested-review-artifact-envelope-application.json`
- `go-markdown-provider-reviewed-nested-review-artifact-envelope-application.json`
- `ruby-markdown-provider-reviewed-nested-review-artifact-envelope-application.json`
