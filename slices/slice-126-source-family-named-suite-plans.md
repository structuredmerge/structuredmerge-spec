# Slice 126: Source Family Named Suite Plans

## Goal

Plan source-language suites through the existing named-suite planning helpers
using backend-specific family plan contexts.

## Scope

- reuse the source-family suite definitions from slice 125
- prove that backend-specific source-family plan contexts participate in named
  suite planning without extra normalization
- preserve stable suite names in planned entries

## Contract

This slice defines one source-family named-suite planning contract:

1. a source-family named suite may be planned through the existing
   `plan_named_conformance_suite_entry` helper
2. the source-family `analysis`, `matching`, and `merge` runs are derived from
   the selected backend-specific family plan context
3. each planned run preserves the suite family, role, and representative case
   identity from the source-family manifest

## Shared Types

- `ConformanceFamilyPlanContext`
- `NamedConformanceSuitePlan`
- `ConformanceSuitePlan`

## Notes

- This slice tests only planning. Execution and reporting stay on the existing
  conformance path.
