# Slice 602: Structured Edit Provider Batch Execution Receipt Replay Workflow Review Request Transport Envelope

## Goal

Make one batch replay-workflow review-request record portable across transport
boundaries.

## Shared Behavior

This slice defines one shared batch replay-workflow review-request envelope
contract:

1. exporting a batch replay-workflow review request yields an envelope with a
   stable `kind`, shared transport `version`, and the nested batch
   replay-workflow review-request payload,
2. importing that envelope restores the same batch replay-workflow review-request
   payload without changing nested replay-workflow review-request artifacts.

## Notes

- This slice keeps the CRISPR-facing batch review-request surface portable.
