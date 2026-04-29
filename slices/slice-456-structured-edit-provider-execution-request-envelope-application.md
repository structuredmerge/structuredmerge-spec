# Slice 456: Structured Edit Provider Execution Request Envelope Application

## Goal

Apply a supported provider execution-request envelope by importing it into the
shared request shape.

## Shared Behavior

This slice defines one shared application contract:

1. a supported envelope imports to the original provider execution request,
2. rejected envelopes preserve the slice-455 rejection behavior.

## Notes

- This slice standardizes envelope application, not provider dispatch.
