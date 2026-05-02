# Slice 559: Structured Edit Provider Execution Receipt Replay Request Transport Rejection

## Goal

Standardize rejection behavior when a provider execution receipt replay-request
envelope cannot be imported.

## Shared Behavior

This slice defines shared replay-request envelope rejection behavior:

1. import rejects the wrong envelope kind,
2. import rejects an unsupported envelope version,
3. the rejection shape remains compatible with the shared transport import
   error contract.

## Notes

- This slice standardizes transport rejection, not replay validation.
