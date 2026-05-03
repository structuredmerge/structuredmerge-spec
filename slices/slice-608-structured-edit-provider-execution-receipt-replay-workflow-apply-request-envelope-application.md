# Slice 608: Structured Edit Provider Execution Receipt Replay Workflow Apply Request Envelope Application

## Goal

Support import-time application of one valid replay-workflow apply-request
envelope.

## Shared Behavior

This slice defines one shared replay-workflow apply-request envelope-application
contract:

1. importing one valid replay-workflow apply-request envelope yields the shared
   apply-request payload unchanged,
2. rejection behavior remains the same as the transport-rejection slice for
   invalid envelopes.

## Notes

- Envelope application is still transport-only; it does not yet execute the
  replay-workflow apply request.
