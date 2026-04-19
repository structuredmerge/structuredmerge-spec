# Slice 43: Conformance Suite Definitions

## Goal

Define named conformance suites directly in the shared manifest.

## Scope

- assign stable names to ordered role sets
- avoid rebuilding the same role list in every host-language harness
- keep suite definition separate from suite planning and execution

## Contract

This slice defines one small suite-definition contract:

1. a conformance manifest may declare named suites
2. each named suite declares one `family` and an ordered `roles` list
3. planning a named suite is equivalent to planning its declared family and
   role list directly
4. suite definitions are descriptive manifest data; they do not alter case
   selection or execution semantics

## Shared Types

- `ConformanceSuiteDefinition`

## Shared Fixture

- `suite-definitions.json`

## Notes

- This slice makes portable suite names part of the shared conformance surface.
- It does not replace direct family-plus-roles planning; it layers on top of it.
