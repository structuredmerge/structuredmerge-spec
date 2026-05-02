# Slice 544: Structured Edit Provider Execution Run Result Envelope Application

## Goal

Standardize envelope application for the shared provider execution run-result
contract.

## Shared Behavior

This slice defines one shared envelope-application contract:

1. importing a valid envelope yields the original provider execution run
   result,
2. run-result metadata remains unchanged across the envelope round trip,
3. rejection behavior from the transport-rejection slice remains unchanged.

## Notes

- This slice standardizes envelope application, not executor implementation
  details.
