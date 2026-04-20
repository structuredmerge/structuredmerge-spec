# Slice 131: Source Families In Canonical Manifest

## Goal

Admit the source-language families into the canonical shared conformance
manifest used by the earlier family and core fixture tests.

## Scope

- extend the canonical manifest's `family_feature_profiles`
- extend the canonical manifest's `families` map
- keep the canonical suite set unchanged for now

## Contract

This slice defines one canonical-manifest widening contract:

1. the canonical conformance manifest may publish `typescript`, `rust`, and
   `go` through `family_feature_profiles`
2. it may publish those families through the normalized `families` map with the
   representative source-family roles `analysis`, `matching`, and `merge`
3. the existing canonical suite set does not need to grow at the same time

## Shared Types

- `ConformanceManifest`
- `ConformanceManifestEntry`

## Notes

- This slice widens the canonical manifest incrementally.
- Source-family named suites remain in the dedicated source-family manifest
  fixtures until a later slice promotes them.
