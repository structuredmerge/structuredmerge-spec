# Slice 49: Conformance Family Plan Context

## Goal

Define the normalized planning context required per family.

## Scope

- separate family planning concerns from execution concerns
- make aggregate suite planning portable across host languages
- keep feature-profile support optional

## Contract

This slice defines one small family plan-context contract:

1. a family plan context includes one `family_profile`
2. it may include one optional `feature_profile`
3. it contains only the data needed to build conformance runs and plans

## Shared Fixture

- `family-plan-context.json`
