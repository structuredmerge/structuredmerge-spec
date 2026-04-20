# Slice 135: TOML Family Backend Feature Profiles

## Goal

Expose backend-specific feature profiles for the TOML family.

## Shared Behavior

This slice defines one TOML family backend-profile contract:

1. a TOML family MAY expose more than one backend-specific feature profile,
2. each backend profile keeps the shared TOML family identity while reporting
   backend-specific capability differences,
3. backend capability differences SHOULD stay narrow and explicit.

## Notes

- Current TOML backend plurality is expected to be visible first in:
  - Ruby: `citrus`, `parslet`
  - TypeScript: `native`, `peggy`
  - Rust: `native`, `pest`
  - Go: `go-toml/v2`, `pigeon`
