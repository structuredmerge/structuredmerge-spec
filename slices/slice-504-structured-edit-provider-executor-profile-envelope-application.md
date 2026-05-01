# Slice 504: Structured Edit Provider Executor Profile Envelope Application

## Goal

Standardize applying a valid provider executor-profile transport envelope back
to the shared executor-profile contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original executor profile,
2. the restored profile remains compatible with the shared nested
   structured-edit profile contracts,
3. rejection behavior from slice 503 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not executor dispatch.
