# Slice 488: Structured Edit Provider Execution Provenance Envelope Application

## Goal

Standardize applying a valid provider execution-provenance transport envelope
back to the shared provenance contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original provenance record,
2. the restored record remains compatible with the shared dispatch and outcome
   contracts,
3. rejection behavior from slice 487 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not executor replay.
