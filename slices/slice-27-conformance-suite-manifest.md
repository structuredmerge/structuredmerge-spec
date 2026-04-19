# Slice 27: Conformance Suite Manifest

## Goal

Expand manifest-driven fixture discovery beyond family profiles.

## Planned Scope

- add representative fixture roles for text and json/jsonc conformance
- keep the manifest intentionally small and portable
- use the manifest from language-specific integration tests

## Shared Behavior

This slice defines one broader conformance-discovery contract:

1. a conformance manifest may group representative fixture paths by family and
   role
2. roles are stable descriptive names rather than implementation-local test names
3. language-specific harnesses may resolve fixture paths through the manifest
4. the manifest is an index, not a replacement for fixture contents

## Shared Types

- `ConformanceManifest`

## Notes

- This slice broadens manifest usage without requiring every fixture to be
  indexed immediately.
