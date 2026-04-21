# Slice 161: Source Suites In Canonical Manifest

## Goal

Promote the stable source-family suites into the canonical conformance
manifest.

## Shared Behavior

This slice defines one canonical source-suite promotion contract:

1. the canonical manifest MAY include the stable source-family portable suite
   descriptors for `typescript`, `rust`, and `go`,
2. the promoted source-family suite descriptors reuse the already-proven `analysis`,
   `matching`, and `merge` roles,
3. the canonical suite-descriptor surface widens to include both stable
   config-family suites and stable source-family suites.
