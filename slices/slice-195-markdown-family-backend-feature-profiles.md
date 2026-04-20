# Slice 195: Markdown Family Backend Feature Profiles

## Goal

Expose backend-specific feature profiles for the Markdown family.

## Shared Behavior

This slice defines one Markdown backend-profile contract:

1. `markdown-merge` MAY expose more than one backend-specific feature profile,
2. each backend profile keeps the shared Markdown family identity,
3. backend plurality is observable through backend identity strings.

## Notes

- The first backend pair is expected to be:
  - a family-local native parser,
  - `kreuzberg-language-pack` as the tree-sitter substrate backend.
- Ruby MAY later split native providers into sibling gems such as
  `kramdown-merge`, while keeping the same family-facing contracts.
