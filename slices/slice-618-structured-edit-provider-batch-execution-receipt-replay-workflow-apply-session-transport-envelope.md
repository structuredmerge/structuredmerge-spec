# Slice 618: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Session Transport Envelope

## Goal

Standardize one portable transport envelope for a provider batch execution
receipt replay-workflow apply-session record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-session
transport envelope:

1. the envelope kind is
   `structured_edit_provider_batch_execution_receipt_replay_workflow_apply_session`,
2. the envelope version is `1`,
3. the envelope payload is one shared provider batch execution receipt
   replay-workflow apply-session record.

## Notes

- This slice carries the batch CRISPR-facing apply-session artifact across the
  same transport boundary used by the single line.
