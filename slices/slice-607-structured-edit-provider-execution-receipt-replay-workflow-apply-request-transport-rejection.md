# Slice 607: Structured Edit Provider Execution Receipt Replay Workflow Apply Request Transport Rejection

## Goal

Reject replay-workflow apply-request envelopes whose transport identity is not
supported.

## Shared Behavior

This slice defines one shared replay-workflow apply-request rejection contract:

1. importing an envelope with the wrong `kind` yields an explicit kind-mismatch
   error,
2. importing an envelope with an unsupported `version` yields an explicit
   unsupported-version error.

## Notes

- Rejection MUST happen before any nested replay-workflow review-request
  payload is treated as accepted.
