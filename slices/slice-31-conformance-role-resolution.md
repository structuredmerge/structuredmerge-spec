# Slice 31: Conformance Role Resolution

## Goal

Define the minimal helper behavior for resolving conformance fixture paths from
the shared manifest.

## Scope

- keep resolution logic deterministic
- separate family feature profile lookup from ordinary family role lookup
- make absence explicit rather than silently fabricating paths

## Contract

This slice defines one helper-level resolution contract:

1. consumers may resolve a family feature profile fixture by family name
2. consumers may resolve a family fixture path by family name plus role
3. resolution returns the manifest-declared path only when an entry exists
4. missing entries remain explicit unresolved lookups rather than implicit
   defaults

## Shared Types

- `ConformanceManifest`
- `ConformanceManifestEntry`

## Notes

- This slice does not require shared filesystem access helpers.
- It only standardizes the portable in-memory lookup behavior.
