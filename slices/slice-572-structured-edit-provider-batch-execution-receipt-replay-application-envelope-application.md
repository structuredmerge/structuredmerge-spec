# Slice 572: Structured Edit Provider Batch Execution Receipt Replay Application Envelope Application

## Goal

Standardize applying one imported batch provider execution receipt replay
application envelope back to the shared batch replay-application contract.

## Shared Behavior

This slice defines shared batch replay-application envelope application
behavior:

1. importing a supported envelope yields one shared batch provider execution
   receipt replay-application record,
2. nested replay-application entries remain unchanged,
3. transport rejection behavior from the batch replay-application envelope line
   remains visible during envelope application.

## Notes

- This slice standardizes batch replay-application envelope application, not
  replay execution semantics.
