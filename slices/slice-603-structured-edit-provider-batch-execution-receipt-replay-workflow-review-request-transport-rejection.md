# Slice 603: Structured Edit Provider Batch Execution Receipt Replay Workflow Review Request Transport Rejection

## Goal

Reject batch replay-workflow review-request envelopes that should not be
imported.

## Shared Behavior

This slice defines shared batch replay-workflow review-request envelope
rejection behavior:

1. importing fails when the envelope `kind` does not match the shared batch
   replay-workflow review-request transport kind,
2. importing fails when the envelope `version` is unsupported,
3. rejection reports the shared transport error category without mutating the
   nested batch replay-workflow review-request payload.

## Notes

- This slice hardens the batch CRISPR-facing review-request surface before it
  becomes part of a larger reusable review/apply workflow.
