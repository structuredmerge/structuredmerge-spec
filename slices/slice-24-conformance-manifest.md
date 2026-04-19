# Slice 24: Conformance Manifest

## Goal

Create a shared manifest for portable fixture discovery.

## Planned Scope

- define a narrow conformance manifest format
- start with family feature profile fixtures
- use the manifest from language-specific integration tests

## Shared Behavior

This slice defines one small conformance contract:

1. a conformance manifest groups a portable subset of fixtures by role
2. each entry records a stable family identity and a relative fixture path
3. language-specific harnesses may use the manifest to discover fixtures
4. the manifest supplements fixture coverage rather than replacing it

## Shared Types

- `ConformanceManifest`

## Notes

- This slice is intentionally small.
- The immediate goal is to reduce hard-coded fixture drift in the family profile
  tests before broadening manifest usage.
