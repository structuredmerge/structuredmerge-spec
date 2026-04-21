# Slice 175: Canonical Stable-Suite Backend Plans

## Goal

Plan the canonical stable suite set through alternate TOML and YAML backends on
each host.

## Shared Behavior

This slice defines one language-local canonical planning contract:

1. the canonical stable suite set remains `json`, `text`, `toml`, `yaml`,
2. TOML and YAML MAY be planned through alternate family backends,
3. backend-specific plan contexts propagate into the planned `toml_portable`
   and `yaml_portable` entries without affecting the other stable families,
4. nested Markdown and delegated Ruby family suites remain non-canonical and do
   not appear in the stable canonical plan set.
