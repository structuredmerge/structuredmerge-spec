# Slice 141: TOML Family in Canonical Manifest

## Goal

Promote TOML into the canonical conformance manifest without yet promoting the
TOML named suite into the canonical suite set.

## Shared Behavior

This slice defines one canonical-manifest widening contract:

1. the canonical manifest MAY include the TOML family feature profile entry,
2. it MAY include the representative TOML roles `analysis`, `matching`, and
   `merge`,
3. this widening does not require the canonical suite set to add
   `toml_portable` immediately.
