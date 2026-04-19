# Slice 15: JSON Fallback Boundaries

## Goal

Define the negative boundary of JSON merge fallback.

## Planned Scope

- template input remains non-recoverable
- strict JSON comment failures are not recovered by merge fallback
- destination fallback remains limited to the declared trailing-comma case

## Shared Behavior

This slice constrains the fallback surface from slice 14:

1. fallback does not apply to invalid template input
2. fallback does not apply to strict JSON comment violations
3. fallback does not apply to destination parse failures outside the declared
   trailing-comma state class
4. when fallback does not apply, the original parse-failure category is
   preserved

## Notes

- This slice exists to prevent silent widening of fallback scope.
- This slice is about policy boundaries, not new recovery behavior.
