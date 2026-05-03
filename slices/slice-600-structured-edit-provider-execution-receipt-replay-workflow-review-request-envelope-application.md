# Slice 600: Structured Edit Provider Execution Receipt Replay Workflow Review Request Envelope Application

## Goal

Apply one supported replay-workflow review-request envelope back to the shared
review-request contract.

## Shared Behavior

This slice defines shared replay-workflow review-request envelope application
behavior:

1. importing a supported envelope yields the same shared replay-workflow
   review-request payload,
2. envelope application preserves the rejection behavior from slice 599.

## Notes

- This slice completes the single replay-workflow review-request transport line.
