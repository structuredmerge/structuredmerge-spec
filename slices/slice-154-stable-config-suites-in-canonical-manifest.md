# Slice 154: Stable Config Suites In Canonical Manifest

## Goal

Promote the stable config-family suites into the canonical manifest.

## Shared Behavior

This slice defines one canonical-suite promotion contract:

1. the canonical manifest MAY expose portable suite descriptors for TOML and
   YAML,
2. the portable suite descriptors for `json`, `text`, `toml`, and `yaml`
   become part of the canonical manifest surface,
3. source-language families remain outside the canonical suite set for now,
4. family-local nested or delegated suites remain outside the canonical suite
   set until a later slice promotes their review and default policy
   explicitly.
