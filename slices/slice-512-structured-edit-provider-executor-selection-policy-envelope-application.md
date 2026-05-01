# Slice 512: Structured Edit Provider Executor Selection Policy Envelope Application

## Goal

Standardize applying a valid provider executor-selection-policy transport
envelope back to the shared selection-policy contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original selection policy,
2. the restored policy remains compatible with the shared executor-selection
   policy contract,
3. rejection behavior from slice 511 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not executor resolution.
