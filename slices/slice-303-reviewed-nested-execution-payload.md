# Slice 303: Reviewed Nested Execution Payload

## Goal

Make reviewed nested execution a first-class shared payload that can be
constructed directly from review-state inputs.

## Scope

- construct one reviewed nested execution payload from:
  - family name,
  - delegated child review state,
  - applied delegated child outputs
- preserve accepted delegated child-group ordering
- preserve applied delegated child outputs unchanged

## Contract

This slice defines one payload-construction contract:

1. `ast-merge` MUST construct a reviewed nested execution payload from the
   supplied family, review state, and applied child outputs
2. the payload MUST preserve the supplied family unchanged
3. the payload MUST preserve delegated child review state unchanged
4. the payload MUST preserve applied delegated child outputs unchanged

## Shared Fixture

- `reviewed-nested-execution-payload.json`
