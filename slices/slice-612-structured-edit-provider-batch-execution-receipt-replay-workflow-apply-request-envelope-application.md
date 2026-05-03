# Slice 612: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Request Envelope Application

## Goal

Support import-time application of one valid batch replay-workflow apply-request
envelope.

## Shared Behavior

This slice defines one shared batch replay-workflow apply-request
envelope-application contract:

1. importing one valid batch replay-workflow apply-request envelope yields the
   shared batch apply-request payload unchanged,
2. rejection behavior remains the same as the transport-rejection slice for
   invalid envelopes.

## Notes

- Envelope application is still transport-only; it does not yet execute the
  batch replay-workflow apply request.
