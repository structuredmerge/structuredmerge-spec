# Slice 129: Source Family Backend-Restricted Plans

## Goal

Plan source-family suites that include backend-restricted roles without changing
the ordinary suite-planning surface.

## Scope

- declare backend-restricted source-family roles through manifest entry
  requirements
- preserve those requirements in planned runs
- keep backend-sensitive roles alongside ordinary source-family roles

## Contract

This slice defines one backend-restricted source-family planning contract:

1. a source-family manifest entry may declare a backend requirement such as a
   native-only parity role
2. planning preserves that backend requirement in the resulting case run
3. suite planning still emits an ordinary ordered plan entry for that role

## Shared Types

- `ConformanceCaseRequirements`
- `NamedConformanceSuitePlan`

## Notes

- Selection and skipping are not part of this slice; this slice only preserves
  backend requirements through planning.
