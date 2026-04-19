# Slice 47: Named Conformance Suite Entry

## Goal

Preserve suite identity alongside named-suite reports.

## Scope

- compose suite-name resolution with named-suite reporting
- provide a stable envelope for aggregate suite reporting
- avoid losing suite identity when reports are collected into lists

## Contract

This slice defines one small named-suite entry contract:

1. a named-suite entry helper consumes a manifest and one suite name
2. it reports that suite through the existing named-suite report helper
3. it returns an envelope with `suite` and `report`
4. it returns `undefined`/`nil`/`None` when the suite name is not declared

## Shared Fixture

- `named-suite-entry.json`

## Notes

- This slice does not add aggregate manifest reporting yet.
- It exists to make later multi-suite reporting deterministic and self-describing.
