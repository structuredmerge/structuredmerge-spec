# Slice 472: Structured Edit Provider Execution Dispatch Envelope Application

## Goal

Standardize applying a valid provider-execution dispatch transport envelope back
to the shared dispatch contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original provider-execution dispatch,
2. the restored dispatch remains compatible with the shared routed-request
   contract,
3. rejection behavior from slice 471 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not dispatch execution.
