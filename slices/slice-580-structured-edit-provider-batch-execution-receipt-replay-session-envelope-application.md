# Slice 580: Structured Edit Provider Batch Execution Receipt Replay Session Envelope Application

## Goal

Standardize applying one imported batch provider execution receipt replay
session envelope back to the shared batch replay-session contract.

## Shared Behavior

This slice defines shared batch replay-session envelope application behavior:

1. importing a supported envelope yields one shared batch provider execution
   receipt replay-session record,
2. nested replay-session entries remain unchanged,
3. transport rejection behavior from the batch replay-session envelope line
   remains visible during envelope application.

## Notes

- This slice standardizes batch replay-session envelope application, not replay
  orchestration semantics.
