# Slice 171: YAML Family Backend Feature Profiles

## Goal

Expose backend-specific feature profiles for the YAML family.

## Shared Behavior

This slice defines one YAML backend-profile contract:

1. a YAML family MAY expose one or more backend-specific feature profiles,
2. each backend profile keeps the shared YAML family identity while reporting
   backend-specific capability differences,
3. backend capability differences SHOULD stay narrow and explicit.

## Notes

- Current YAML backend plurality may be split between substrate and provider
  packages. It is expected to be visible first in:
  - Ruby: `psych`, `kreuzberg-language-pack`
  - TypeScript: `yaml`, `js-yaml`
  - Rust: `serde_yaml`, `yaml_serde`
  - Go: `yaml-v3`, `goccy-go-yaml`
