# Slice 195: Markdown Family Backend Feature Profiles

## Goal

Expose backend-specific feature profiles for the Markdown family.

## Shared Behavior

This slice defines one Markdown backend-profile contract:

1. `markdown-merge` exposes the built-in tree-sitter backend feature profile for the Markdown family,
2. that backend profile keeps the shared Markdown family identity,
3. native parser backends are exposed by discrete provider packages, not by `markdown-merge`.

## Notes

- `kreuzberg-language-pack` is the expected tree-sitter substrate backend.
- Native providers such as `markdown-it-merge`, `kramdown-merge`,
  `commonmarker-merge`, and `markly-merge` define their own backend
  feature-profile contracts.
