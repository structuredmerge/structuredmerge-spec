# Slice 47: Named Conformance Suite Entry

## Goal

Preserve suite identity alongside suite-descriptor reports.

## Scope

- compose suite-selector resolution with suite-descriptor reporting
- provide a stable envelope for aggregate suite reporting
- avoid losing suite identity when reports are collected into lists

## Contract

This slice defines one small suite-descriptor entry contract:

1. a suite-descriptor entry helper consumes a manifest and one suite selector
2. it reports that suite through the existing suite-descriptor report helper
3. it returns an envelope with `suite` and `report`
4. `suite` carries the full structured suite descriptor
5. it returns `undefined`/`nil`/`None` when the suite selector is not declared

## Shared Fixture

- `named-suite-entry.json`

## Notes

- This slice does not add aggregate manifest reporting yet.
- It exists to make later multi-suite reporting deterministic and self-describing.
