# Slice 45: Named Conformance Suite Runner

## Goal

Define a normalized runner helper for manifest suite descriptors.

## Scope

- compose suite-descriptor lookup with planning and execution
- avoid reimplementing the same suite-descriptor run flow in each host language
- preserve the existing case-result shape

## Contract

This slice defines one small suite-descriptor runner contract:

1. a suite-descriptor runner helper consumes a manifest and one suite selector
2. it resolves the suite definition from the manifest
3. it plans the suite using the existing suite-descriptor planning helper
4. it executes through the existing planned-suite runner helper
5. it returns `undefined`/`nil`/`None` when the suite selector is not declared

## Shared Fixture

- `named-suite-runner.json`

## Notes

- This slice is the execution companion to slice 44.
- It does not introduce a new result envelope.
