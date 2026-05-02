# Slice 547: Structured Edit Provider Batch Execution Run Result Transport Rejection

## Goal

Standardize import rejection for provider batch execution run-result envelopes
when transport identity is wrong or unsupported.

## Shared Behavior

This slice defines one shared batch transport-rejection contract:

1. importing an envelope with the wrong `kind` yields a stable kind-mismatch
   error,
2. importing an envelope with an unsupported `version` yields a stable
   unsupported-version error,
3. rejection is reported without mutating the batch execution run-result
   payload.

## Notes

- This slice standardizes rejection semantics, not executor implementation
  details.
