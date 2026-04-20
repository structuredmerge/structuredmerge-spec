# Slice 203: Markdown Substrate And Provider Boundary

## Goal

Clarify how the Markdown family splits substrate logic from parser-provider
packages.

## Shared Behavior

This slice defines the Markdown packaging boundary:

1. `markdown-merge` MAY act as the family substrate package.
2. The family substrate MAY host the primary tree-sitter-backed Markdown path.
3. Native Markdown parsers MAY be exposed through sibling provider packages.
4. Substrate and provider packages MUST preserve the same family-facing
   contracts for analysis, matching, planning, and reporting.

## Notes

- This keeps parser-specific installation pressure out of the substrate package
  when a native parser is optional or environment-sensitive.
- Ruby is the first motivating example:
  - `markdown-merge` as substrate
  - `kramdown-merge`, `commonmarker-merge`, and `markly-merge` as native
    providers
- TypeScript, Rust, and Go MAY follow the same pattern with one native provider
  package apiece while keeping tree-sitter in the substrate package.
