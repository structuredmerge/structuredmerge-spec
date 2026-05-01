# Slice 508: Structured Edit Provider Executor Registry Envelope Application

## Goal

Standardize applying a valid provider executor-registry transport envelope back
to the shared executor-registry contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original executor registry,
2. the restored registry remains compatible with the shared single
   executor-profile contract,
3. rejection behavior from slice 507 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not executor selection.
