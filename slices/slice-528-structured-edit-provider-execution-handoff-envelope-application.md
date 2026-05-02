# Slice 528: Structured Edit Provider Execution Handoff Envelope Application

## Goal

Standardize applying a valid provider execution-handoff transport envelope back
to the shared execution-handoff contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original execution handoff,
2. the restored handoff remains compatible with the shared execution-plan and
   execution-dispatch contracts,
3. rejection behavior from slice 527 remains unchanged for invalid envelopes.

## Notes

- This slice standardizes envelope application, not execution output.
