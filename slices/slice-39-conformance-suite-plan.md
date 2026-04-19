# Slice 39: Conformance Suite Plan

## Goal

Define a normalized planning layer that derives an executable conformance suite
from the shared manifest.

## Scope

- preserve requested role order
- bind manifest roles to their fixture paths
- make missing roles observable without executing anything

## Contract

This slice defines one small suite-planning contract:

1. a suite plan is derived from a manifest, one family, and an ordered role
   list
2. each manifest role that resolves for the family produces one ordered plan
   entry
3. each plan entry carries the resolved fixture `path` plus a normalized
   `run`
4. each generated run uses the requested family profile and optional feature
   profile
5. the generated case name defaults to the manifest role name
6. unresolved roles are preserved in an ordered `missing_roles` list
7. planning is distinct from selection and execution

## Shared Types

- `ConformanceSuitePlanEntry`
- `ConformanceSuitePlan`

## Shared Fixture

- `suite-plan.json`

## Notes

- This slice turns the shared manifest into a reusable suite-planning surface.
- It does not introduce per-case capability requirements yet. Generated runs use
  empty requirements until a later slice declares manifest-side case
  requirements.
