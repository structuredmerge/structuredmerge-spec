# Slice 155: Canonical Stable-Suite Plans

## Goal

Plan the stable config-family suites directly from the canonical manifest.

## Shared Behavior

This slice defines one canonical stable-suite planning contract:

1. the canonical manifest MAY plan the portable suite descriptors for `json`,
   `text`, `toml`, and `yaml`,
2. families without canonical suites remain inert during this planning pass,
3. the stable suite order remains `json`, `text`, `toml`, `yaml`.
