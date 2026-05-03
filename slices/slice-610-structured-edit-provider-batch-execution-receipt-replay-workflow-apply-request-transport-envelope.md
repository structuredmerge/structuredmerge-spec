# Slice 610: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Request Transport Envelope

## Goal

Standardize one transport envelope for a batch replay-workflow apply request.

## Shared Behavior

This slice defines one shared batch replay-workflow apply-request transport
contract:

1. exporting a batch replay-workflow apply request yields an envelope with a
   stable `kind` and shared transport `version`,
2. importing the same envelope yields the original shared batch replay-workflow
   apply request unchanged.

## Notes

- The envelope MUST preserve batch ordering.
