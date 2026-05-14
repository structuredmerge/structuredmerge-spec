# Slice 759: Markdown Provider Documentation Decision

## Goal

Document Markdown backend support from current backend/provider profiles rather
than old Ruby runtime compatibility tables.

## Current Provider Profile Evidence

Current provider fixtures define these provider packages:

- Go: `goldmarkmerge` with backend `goldmark`.
- Ruby: `commonmarker-merge` with backend `commonmarker`.
- Ruby: `markly-merge` with backend `markly`.
- Ruby: `kramdown-merge` with backend `kramdown`.
- Rust: `pulldown-cmark-merge` with backend `pulldown-cmark`.
- TypeScript: `@structuredmerge/markdown-it-merge` with backend
  `markdown-it`.

## Decision

`markdown-merge` is the canonical Markdown family package. Provider packages
own parser-specific docs, backend defaults, parser options, and runtime
constraints. Generated family/backend sections should point to provider
profiles and avoid old Ruby-only compatibility tables.

## Generated README Requirement

The shared generated family/backend section should include a Markdown provider
note naming the current provider packages and making the family/provider
boundary explicit.

## Boundary

This slice documents the provider support decision. It does not add the future
Markdown utility fixtures from slices 757 and 758.
