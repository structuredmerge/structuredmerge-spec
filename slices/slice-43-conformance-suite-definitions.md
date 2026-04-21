# Slice 43: Conformance Suite Definitions

## Goal

Define structured conformance suite descriptors directly in the shared
manifest.

## Scope

- assign stable structured identity to ordered role sets
- avoid rebuilding the same role list in every host-language harness
- keep suite definition separate from suite planning and execution

## Contract

This slice defines one small suite-definition contract:

1. a conformance manifest may declare ordered suite descriptors
2. each suite descriptor declares one `kind`, one `subject`, and an ordered
   `roles` list
3. `subject` carries language or grammar identity as data rather than encoding
   it in a top-level suite label
4. planning a suite descriptor is equivalent to planning its declared family
   and role list directly
5. suite descriptors are descriptive manifest data; they do not alter case
   selection or execution semantics

## Shared Types

- `ConformanceSuiteDefinition`

## Shared Fixture

- `suite-definitions.json`

## Notes

- This slice makes structured suite identity part of the shared conformance
  surface.
- It does not replace direct family-plus-roles planning; it layers on top of
  it.
