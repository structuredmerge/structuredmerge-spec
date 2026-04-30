# Slice 480: Structured Edit Provider Execution Outcome Envelope Application

## Goal

Standardize applying a valid provider-execution outcome transport envelope back
to the shared execution-outcome contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original provider-execution outcome,
2. the restored outcome remains compatible with the shared dispatch and
   application contracts,
3. rejection behavior from slice 479 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not executor replay.
