# Slice 148: Config-Family Aggregate Manifest

## Goal

Aggregate the stable config-oriented families into one shared conformance
manifest.

## Shared Behavior

This slice defines one config-family aggregate manifest contract:

1. the manifest exposes the family profiles for `json`, `text`, `toml`, and
   `yaml`,
2. it defines one portable suite descriptor per config family,
3. it maps each descriptor to the representative family roles already defined
   by the family-specific slices.
