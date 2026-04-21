# Slice 51: Named Conformance Suite Results

## Goal

Preserve suite identity alongside suite-descriptor execution results.

## Scope

- compose suite-descriptor running with a stable suite envelope
- avoid losing suite identity when execution results are collected into lists
- keep the existing case-result shape

## Contract

This slice defines one small suite-descriptor results contract:

1. a suite-descriptor results helper consumes a manifest and one suite selector
2. it runs that suite through the existing suite-descriptor runner helper
3. it returns an envelope with `suite` and `results`
4. it returns `undefined`/`nil`/`None` when the suite selector is not declared

## Shared Fixture

- `named-suite-results.json`
