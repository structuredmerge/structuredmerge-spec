# Slice 128: Source Family Manifest Report

## Goal

Report a source-family conformance manifest through a mixed set of backend-aware
family plan contexts.

## Scope

- reuse the source-family manifest and named suites
- allow different source families to select different backends in one manifest
  report
- preserve ordinary named-suite report and manifest-summary behavior

## Contract

This slice defines one source-family manifest reporting contract:

1. a source-family conformance manifest may be reported through one set of
   backend-aware family plan contexts
2. those contexts may mix tree-sitter-backed and native backends across
   different families
3. manifest reporting preserves ordinary named-suite report entries and one
   aggregate summary
4. no additional diagnostics are required when all suite roles are satisfied

## Shared Types

- `ConformanceManifestReport`
- `NamedConformanceSuiteReportEnvelope`

## Notes

- This slice proves that backend plurality composes at the manifest-report
  level, not just at individual family planning.
