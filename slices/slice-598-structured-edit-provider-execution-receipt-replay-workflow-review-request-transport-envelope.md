# Slice 598: Structured Edit Provider Execution Receipt Replay Workflow Review Request Transport Envelope

## Goal

Make one replay-workflow review-request record portable across transport
boundaries.

## Shared Behavior

This slice defines one shared replay-workflow review-request envelope contract:

1. exporting a replay-workflow review request yields an envelope with a stable
   `kind`, shared transport `version`, and the nested replay-workflow
   review-request payload,
2. importing that envelope restores the same replay-workflow review-request
   payload without changing nested replay-workflow result artifacts.

## Notes

- This slice keeps the CRISPR-facing review-request surface portable without
  flattening nested replay-workflow result data.
