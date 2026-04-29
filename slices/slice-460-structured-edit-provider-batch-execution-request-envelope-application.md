# Slice 460: Structured Edit Provider Batch Execution Request Envelope Application

## Goal

Apply a supported provider batch execution-request envelope by importing it
into the shared batch request shape.

## Shared Behavior

This slice defines one shared application contract:

1. a supported envelope imports to the original provider batch execution
   request,
2. rejected envelopes preserve the slice-459 rejection behavior.

## Notes

- This slice standardizes envelope application, not provider dispatch.
