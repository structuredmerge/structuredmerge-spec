# Slice 44: Named Conformance Suite Report

## Goal

Define a normalized report helper for manifest suite descriptors.

## Scope

- compose suite-descriptor lookup with planning and reporting
- avoid reimplementing the same suite-descriptor flow in each host language
- preserve the existing report shape

## Contract

This slice defines one small suite-descriptor report contract:

1. a suite-descriptor report helper consumes a manifest and one suite selector
2. it resolves the suite definition from the manifest
3. it plans the suite using the existing suite-descriptor planning helper
4. it executes and reports through the existing planned-suite report helper
5. it returns `undefined`/`nil`/`None` when the suite selector is not declared

## Shared Fixture

- `named-suite-report.json`

## Notes

- This slice is a composition helper above slices 43, 39, 40, and 41.
- It does not introduce a new report envelope or outcome model.
