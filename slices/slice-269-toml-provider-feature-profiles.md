# Slice 269: TOML Provider Feature Profiles

## Goal

Expose feature profiles for non-tree-sitter TOML provider packages.

## Shared Behavior

This slice defines one TOML provider-profile contract:

1. each TOML provider package keeps the shared TOML family identity,
2. each provider package exposes exactly one non-tree-sitter backend identity,
3. provider feature profiles remain family-compatible with the TOML substrate.

## Notes

- TypeScript uses `@structuredmerge/peggy-toml-merge` as the first explicit
  provider package.
- Other hosts may use different provider-package names while preserving the
  same family-facing contract.
