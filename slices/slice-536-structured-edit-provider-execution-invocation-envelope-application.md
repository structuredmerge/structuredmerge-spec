# Slice 536: Structured Edit Provider Execution Invocation Envelope Application

## Goal

Standardize envelope application for the shared provider execution-invocation
contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original execution invocation,
2. invocation metadata remains unchanged across the envelope round trip,
3. rejection behavior from the transport-rejection slice remains unchanged.

## Notes

- This slice standardizes envelope application, not executor behavior.
