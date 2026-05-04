# Slice 686: Structured Edit Request Envelope Application

## Goal

Standardize applying the supported structured edit request envelope back to the
shared request contract.

## Shared Behavior

This slice defines one shared envelope-application surface:

1. import of a supported envelope yields the embedded structured edit request,
2. the callable destination descriptor remains intact after transport,
3. rejection behavior from slice 685 remains unchanged.

## Notes

- This slice completes the generic request transport ladder for the
  callable-destination conformance payload.
