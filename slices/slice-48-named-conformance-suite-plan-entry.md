# Slice 48: Named Conformance Suite Plan Entry

## Goal

Preserve suite identity alongside suite-descriptor plans.

## Scope

- compose suite-selector resolution with suite-descriptor planning
- provide a stable envelope for later aggregate planning and reporting
- avoid losing suite identity when plans are collected into lists

## Contract

This slice defines one small suite-descriptor plan-entry contract:

1. a suite-descriptor plan-entry helper consumes a manifest and one suite
   selector
2. it plans that suite through the existing suite-descriptor planning helper
3. it returns an envelope with `suite` and `plan`
4. `suite` carries the full structured suite descriptor
5. it returns `undefined`/`nil`/`None` when the suite selector is not declared

## Shared Fixture

- `named-suite-plan-entry.json`
