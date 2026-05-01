# Slice 492: Structured Edit Provider Batch Execution Provenance Envelope Application

## Goal

Standardize applying a valid provider batch execution-provenance transport
envelope back to the shared batch-provenance contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original batch provenance,
2. the restored batch remains compatible with the shared single-provenance
   contract,
3. rejection behavior from slice 491 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not batch executor replay.
