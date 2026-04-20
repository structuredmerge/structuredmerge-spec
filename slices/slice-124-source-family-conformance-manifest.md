# Slice 124: Source Family Conformance Manifest

## Goal

Admit the source-language families into the normalized conformance manifest
through the same family-profile and role-based fixture paths already used by
the config and text families.

## Scope

- keep source-family manifest entries aligned with the normalized manifest shape
- avoid a source-language-specific manifest structure
- admit only the stable representative roles already proven by the source-family
  slices

## Contract

This slice defines one source-family manifest contract:

1. a normalized conformance manifest may declare `typescript`, `rust`, and `go`
   through `family_feature_profiles`
2. each source family may publish stable representative roles through the
   existing `families` map
3. the representative source-family roles are `analysis`, `matching`, and
   `merge`
4. consumers resolve source-family fixtures through the same
   `conformance_family_feature_profile_path` and `conformance_fixture_path`
   helpers used for the earlier families

## Shared Types

- `ConformanceManifest`
- `ConformanceManifestEntry`

## Notes

- This slice intentionally uses a dedicated source-family manifest fixture rather
  than mutating the earlier shared `json`/`text` manifest.
- The goal is to prove that source-language families fit the normalized
  manifest path before broadening the older aggregate manifest fixtures.
