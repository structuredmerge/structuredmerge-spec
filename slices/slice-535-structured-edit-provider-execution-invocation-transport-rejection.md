# Slice 535: Structured Edit Provider Execution Invocation Transport Rejection

## Goal

Standardize import rejection for provider execution-invocation envelopes when
transport identity is wrong or unsupported.

## Shared Behavior

This slice defines one shared transport-rejection contract:

1. importing an envelope with the wrong `kind` yields a stable kind-mismatch
   error,
2. importing an envelope with an unsupported `version` yields a stable
   unsupported-version error,
3. rejection is reported without mutating the invocation payload.

## Notes

- This slice standardizes rejection semantics, not executor behavior.
