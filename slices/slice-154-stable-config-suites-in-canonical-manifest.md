# Slice 154: Stable Config Suites In Canonical Manifest

## Goal

Promote the stable config-family suites into the canonical manifest.

## Shared Behavior

This slice defines one canonical-suite promotion contract:

1. the canonical manifest MAY expose `toml_portable` and `yaml_portable`,
2. the suite names `json_portable`, `text_portable`, `toml_portable`, and
   `yaml_portable` become part of the canonical manifest surface,
3. source-language families remain outside the canonical suite set for now.
