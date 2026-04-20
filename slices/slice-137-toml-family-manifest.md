# Slice 137: TOML Family Manifest

## Goal

Expose the TOML family through a dedicated conformance manifest.

## Shared Behavior

This slice defines one TOML family manifest contract:

1. the manifest exposes the TOML family feature profile fixture,
2. it maps the family roles `analysis`, `matching`, and `merge` to the shared
   TOML fixtures,
3. it MAY define a named suite such as `toml_portable` over those roles.

## Notes

- This manifest is intentionally separate from the canonical manifest while the
  TOML backend-plurality path is still being widened.
