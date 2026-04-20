# Slice 204: Markdown Provider Feature Profiles

## Goal

Expose feature profiles for native Markdown provider packages.

## Shared Behavior

This slice defines one provider-profile contract:

1. each native Markdown provider package keeps the shared Markdown family
   identity,
2. provider packages expose exactly one native backend reference,
3. provider feature profiles remain family-compatible with the Markdown
   substrate.

## Notes

- Expected first providers:
  - TypeScript: `markdown-it-merge`
  - Rust: `pulldown-cmark-merge`
  - Go: `goldmarkmerge`
  - Ruby: `kramdown-merge`, `commonmarker-merge`, `markly-merge`
