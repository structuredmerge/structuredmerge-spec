# Slice 468: Structured Edit Provider Batch Execution Report Envelope Application

## Goal

Apply a supported provider batch execution-report envelope by importing it into
the shared batch report shape.

## Shared Behavior

This slice defines one shared application contract:

1. a supported envelope imports to the original provider batch execution
   report,
2. rejected envelopes preserve the slice-467 rejection behavior.

## Notes

- This slice standardizes envelope application, not provider dispatch.
