# Slice 45: Named Conformance Suite Runner

## Goal

Define a normalized runner helper for named manifest suites.

## Scope

- compose suite-definition lookup with planning and execution
- avoid reimplementing the same named-suite run flow in each host language
- preserve the existing case-result shape

## Contract

This slice defines one small named-suite runner contract:

1. a named-suite runner helper consumes a manifest and one suite name
2. it resolves the suite definition from the manifest
3. it plans the suite using the existing named-suite planning helper
4. it executes through the existing planned-suite runner helper
5. it returns `undefined`/`nil`/`None` when the suite name is not declared

## Shared Fixture

- `named-suite-runner.json`

## Notes

- This slice is the execution companion to slice 44.
- It does not introduce a new result envelope.
