# Slice 467: Structured Edit Provider Batch Execution Report Transport Rejection

## Goal

Reject invalid transport envelopes for provider batch execution reports.

## Shared Behavior

This slice defines two shared rejection cases:

1. wrong envelope `kind` is rejected,
2. unsupported envelope `version` is rejected.

## Notes

- Rejection diagnostics should stay aligned with the existing structured-edit
  transport vocabulary.
