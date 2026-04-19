# Slice 48: Named Conformance Suite Plan Entry

## Goal

Preserve suite identity alongside named-suite plans.

## Scope

- compose suite-name resolution with named-suite planning
- provide a stable envelope for later aggregate planning and reporting
- avoid losing suite identity when plans are collected into lists

## Contract

This slice defines one small named-suite plan-entry contract:

1. a named-suite plan-entry helper consumes a manifest and one suite name
2. it plans that suite through the existing named-suite planning helper
3. it returns an envelope with `suite` and `plan`
4. it returns `undefined`/`nil`/`None` when the suite name is not declared

## Shared Fixture

- `named-suite-plan-entry.json`
