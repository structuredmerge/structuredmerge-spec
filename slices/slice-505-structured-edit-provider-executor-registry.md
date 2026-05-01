# Slice 505: Structured Edit Provider Executor Registry

## Goal

Standardize an ordered registry of provider executor profiles.

## Shared Behavior

This slice defines one shared executor-registry contract:

1. the registry carries ordered `executor_profiles`,
2. each entry remains compatible with the shared single executor-profile
   contract,
3. registry metadata may remain visible without changing the executor-profile
   entries.

## Notes

- This slice standardizes discovery aggregation, not dispatch.
