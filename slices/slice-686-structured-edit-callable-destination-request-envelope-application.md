# Slice 686: Structured Edit Callable Destination Request Envelope Application

## Goal

Standardize applying the supported callable-destination request envelope back
to the shared request contract.

## Shared Behavior

This slice defines one shared envelope-application surface:

1. import of a supported envelope yields the embedded callable-destination
   request,
2. the callable destination descriptor remains intact after transport,
3. rejection behavior from slice 685 remains unchanged.

## Notes

- This slice completes the callable-destination request transport ladder.
