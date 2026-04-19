# Slice 44: Named Conformance Suite Report

## Goal

Define a normalized report helper for named manifest suites.

## Scope

- compose suite-definition lookup with planning and reporting
- avoid reimplementing the same named-suite flow in each host language
- preserve the existing report shape

## Contract

This slice defines one small named-suite report contract:

1. a named-suite report helper consumes a manifest and one suite name
2. it resolves the suite definition from the manifest
3. it plans the suite using the existing named-suite planning helper
4. it executes and reports through the existing planned-suite report helper
5. it returns `undefined`/`nil`/`None` when the suite name is not declared

## Shared Fixture

- `named-suite-report.json`

## Notes

- This slice is a composition helper above slices 43, 39, 40, and 41.
- It does not introduce a new report envelope or outcome model.
