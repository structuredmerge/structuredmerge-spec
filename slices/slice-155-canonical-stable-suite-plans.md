# Slice 155: Canonical Stable-Suite Plans

## Goal

Plan the stable config-family suites directly from the canonical manifest.

## Shared Behavior

This slice defines one canonical stable-suite planning contract:

1. the canonical manifest MAY plan `json_portable`, `text_portable`,
   `toml_portable`, and `yaml_portable`,
2. families without canonical suites remain inert during this planning pass,
3. the stable suite order remains `json`, `text`, `toml`, `yaml`.
