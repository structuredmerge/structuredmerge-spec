# Slice 197: Markdown Family Manifest

## Goal

Expose the Markdown family through a dedicated conformance manifest.

## Shared Behavior

This slice defines one Markdown family manifest contract:

1. the manifest exposes the Markdown family feature profile fixture,
2. it maps the family roles `analysis`, `matching`, and `merge` to the shared
   Markdown fixtures,
3. it MAY define one portable suite descriptor over those roles.

## Notes

- Markdown is intentionally not part of the canonical manifest yet.
- This family manifest exists so the substrate can widen before canonical
  review-state expectations are forced onto it.
