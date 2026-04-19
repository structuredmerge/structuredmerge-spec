# Slice 22: Shared Family Feature Profile

## Goal

Define a normalized core shape for family-level feature profiles.

## Planned Scope

- add a portable `FamilyFeatureProfile` concept to the core contract layer
- keep the shape descriptive rather than executable
- support families with and without explicit dialect subdivisions

## Shared Behavior

This slice defines one core reporting contract:

1. a shared family feature profile identifies a merge family
2. it reports supported dialect identifiers as an ordered list
3. families without explicit dialect variants report an empty dialect list
4. it reports supported policy references for that family
5. it remains distinct from adapter feature profiles and active result policies

## Shared Types

- `FamilyFeatureProfile`

## Notes

- This slice generalizes the family-profile concept introduced for `json-merge`.
- It does not remove family-specific host-language types when those remain
  useful.
