# Slice 30: Normalized Conformance Manifest

## Goal

Normalize the conformance manifest so fixture discovery is family-driven rather
than hard-coded by top-level manifest keys.

## Scope

- keep the manifest small and portable
- separate family-profile entries from family fixture entries
- avoid embedding implementation-local suite structure into the shared manifest

## Contract

This slice defines one normalized manifest contract:

1. a conformance manifest reports family feature profile entries through
   `family_feature_profiles`
2. it reports family fixture entries through a `families` map keyed by stable
   family name
3. each manifest entry carries a stable descriptive `role`
4. each manifest entry carries a portable fixture `path`
5. consumers resolve fixtures by family plus role rather than by family-specific
   top-level manifest fields

## Shared Types

- `ConformanceManifestEntry`
- `ConformanceManifest`

## Notes

- This slice preserves the existing role vocabulary while normalizing the
  manifest shape around family selection.
- `diagnostics` remains a family in the manifest rather than a special-case
  out-of-band fixture bucket.
