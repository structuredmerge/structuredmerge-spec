# Slice 516: Structured Edit Provider Executor Resolution Envelope Application

## Goal

Standardize applying a valid provider executor-resolution transport envelope
back to the shared executor-resolution contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original executor resolution,
2. the restored resolution remains compatible with the shared executor-registry,
   executor-selection-policy, and executor-profile contracts,
3. rejection behavior from slice 515 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not execution outcome.
