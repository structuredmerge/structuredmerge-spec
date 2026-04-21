# Slice 125: Source Family Suite Definitions

## Goal

Expose the source-language families through the same suite-descriptor mechanism used
by the earlier conformance families.

## Scope

- define portable suite descriptors for `typescript`, `rust`, and `go`
- keep suite structure family-oriented rather than backend-specific
- reuse the normalized manifest and suite-definition helpers

## Contract

This slice defines one source-family suite-definition contract:

1. a conformance manifest may declare portable suite descriptors for
   `typescript`, `rust`, and `go`
2. each source-family suite descriptor references the representative
   `analysis`, `matching`, and `merge` roles
3. suite lookup and suite-selector enumeration use the existing normalized
   manifest helpers unchanged

## Shared Types

- `ConformanceManifest`
- `ConformanceSuiteDefinition`

## Notes

- Backend choice remains outside the suite definition itself.
- Source-family suites rely on the backend-specific family plan contexts added
  in slice 123.
