## Slice 277: YAML Provider Feature Profiles

## Goal

Expose feature profiles for non-tree-sitter YAML provider packages.

## Shared Behavior

This slice defines one YAML provider-profile contract:

1. each YAML provider package keeps the shared YAML family identity,
2. each provider package exposes exactly one non-tree-sitter backend identity,
3. provider feature profiles remain family-compatible with the YAML substrate.

## Notes

- the first TypeScript YAML provider package is `js-yaml-merge`
- other hosts may expose additional YAML providers while preserving the same
  family-facing contract
