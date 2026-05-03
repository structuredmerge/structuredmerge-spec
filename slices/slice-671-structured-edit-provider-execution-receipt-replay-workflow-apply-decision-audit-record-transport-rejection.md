# Slice 671: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Audit Record Transport Rejection

## Goal

Standardize transport rejection for one replay-workflow apply-decision
audit-record envelope.

## Shared Behavior

This slice defines one shared replay-workflow apply-decision audit-record
transport rejection surface:

1. import rejects an envelope with the wrong `kind`,
2. import rejects an envelope with an unsupported `version`,
3. rejection leaves the nested audit-record payload unapplied.

## Notes

- This slice keeps the final audit artifact transport strict and portable.
