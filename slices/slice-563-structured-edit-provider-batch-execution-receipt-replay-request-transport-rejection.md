# Slice 563: Structured Edit Provider Batch Execution Receipt Replay Request Transport Rejection

## Goal

Standardize rejection behavior when a batch provider execution receipt
replay-request envelope cannot be imported.

## Shared Behavior

This slice defines shared batch replay-request envelope rejection behavior:

1. import rejects the wrong envelope kind,
2. import rejects an unsupported envelope version,
3. the rejection shape remains compatible with the shared transport import
   error contract.

## Notes

- This slice standardizes transport rejection, not batch replay validation.
