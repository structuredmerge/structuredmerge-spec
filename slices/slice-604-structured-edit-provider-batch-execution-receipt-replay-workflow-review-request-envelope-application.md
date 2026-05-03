# Slice 604: Structured Edit Provider Batch Execution Receipt Replay Workflow Review Request Envelope Application

## Goal

Apply one supported batch replay-workflow review-request envelope back to the
shared batch review-request contract.

## Shared Behavior

This slice defines shared batch replay-workflow review-request envelope
application behavior:

1. importing a supported envelope yields the same shared batch replay-workflow
   review-request payload,
2. envelope application preserves the rejection behavior from slice 603.

## Notes

- This slice completes the batch replay-workflow review-request transport line.
