# Slice 51: Named Conformance Suite Results

## Goal

Preserve suite identity alongside named-suite execution results.

## Scope

- compose named-suite running with a stable suite envelope
- avoid losing suite identity when execution results are collected into lists
- keep the existing case-result shape

## Contract

This slice defines one small named-suite results contract:

1. a named-suite results helper consumes a manifest and one suite name
2. it runs that suite through the existing named-suite runner helper
3. it returns an envelope with `suite` and `results`
4. it returns `undefined`/`nil`/`None` when the suite name is not declared

## Shared Fixture

- `named-suite-results.json`
