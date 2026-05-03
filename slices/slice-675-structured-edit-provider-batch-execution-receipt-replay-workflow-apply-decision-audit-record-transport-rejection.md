# Slice 675: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Decision Audit Record Transport Rejection

## Goal

Standardize transport rejection for one batch replay-workflow apply-decision
audit-record envelope.

## Shared Behavior

This slice defines one shared batch replay-workflow apply-decision
audit-record transport rejection surface:

1. import rejects an envelope with the wrong `kind`,
2. import rejects an envelope with an unsupported `version`,
3. rejection leaves the ordered nested audit-record payload unapplied.

## Notes

- This slice keeps the final batch audit artifact transport strict and
  portable.
