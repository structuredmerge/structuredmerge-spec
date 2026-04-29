# Slice 445: Structured Edit Batch Report Transport Rejection

## Goal

Reject invalid structured-edit batch report transport envelopes at import time.

## Shared Behavior

This slice defines one narrow rejection contract:

1. importing fails when the envelope `kind` is not the structured-edit batch
   report transport kind,
2. importing fails when the envelope `version` is unsupported,
3. rejection happens before any enclosed batch report is exposed.

## Notes

- This slice hardens the shared transport edge introduced by slice 444.
