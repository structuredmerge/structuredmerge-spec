# Slice 130: Source Family Backend-Restricted Report

## Goal

Report source-family suites that include backend-restricted roles through a
non-matching backend context and preserve explicit skipped results.

## Scope

- reuse the backend-restricted source-family suites from slice 129
- run them through tree-sitter-backed contexts
- prove that native-only roles become explicit skipped results

## Contract

This slice defines one backend-restricted source-family reporting contract:

1. a source-family backend-restricted role becomes an explicit skipped result
   when the active backend does not satisfy the role requirement
2. ordinary unrestricted roles in the same suite still execute and report
   normally
3. suite and manifest summaries count those backend-restricted cases as
   `skipped`

## Shared Types

- `ConformanceManifestReport`
- `ConformanceCaseResult`

## Notes

- This slice composes the earlier backend-aware selection model with the
  source-family manifest path.
