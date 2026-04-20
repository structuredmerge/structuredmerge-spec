# Slice 127: Source Family Native Suite Plans

## Goal

Prove that the source-family named suites can be planned through native parser
backends without changing suite shape or role vocabulary.

## Scope

- reuse the source-family manifest and suite definitions
- swap backend-specific family plan contexts from tree-sitter-backed adapters to
  native adapters
- keep the planned suite entries otherwise unchanged

## Contract

This slice defines one native-backend source-family planning contract:

1. a source-family named suite may be planned through a native backend family
   plan context
2. the suite roles remain `analysis`, `matching`, and `merge`
3. only the backend-specific feature profile changes between tree-sitter and
   native planning

## Shared Types

- `ConformanceFamilyPlanContext`
- `NamedConformanceSuitePlan`

## Notes

- This slice proves backend plurality without introducing backend-specific suite
  names.
