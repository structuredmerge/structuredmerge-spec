# Slice 143: YAML Family Manifest

## Goal

Expose the YAML family through a dedicated conformance manifest.

## Shared Behavior

This slice defines one YAML family manifest contract:

1. the manifest exposes the YAML family feature profile fixture,
2. it maps the family roles `analysis`, `matching`, and `merge` to the shared
   YAML fixtures,
3. it MAY define a named suite such as `yaml_portable` over those roles.

## Notes

- This manifest is intentionally separate from the canonical manifest while the
  YAML family planning path is first being widened.
