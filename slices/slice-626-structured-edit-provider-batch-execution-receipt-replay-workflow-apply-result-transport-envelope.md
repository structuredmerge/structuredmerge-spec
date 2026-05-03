# Slice 626: Structured Edit Provider Batch Execution Receipt Replay Workflow Apply Result Transport Envelope

## Goal

Standardize one portable transport envelope for a provider batch execution
receipt replay-workflow apply-result record.

## Shared Behavior

This slice defines one shared batch receipt replay-workflow apply-result
transport envelope:

1. the envelope kind is
   `structured_edit_provider_batch_execution_receipt_replay_workflow_apply_result`,
2. the envelope version is `1`,
3. the envelope payload is one shared provider batch execution receipt
   replay-workflow apply-result record.

## Notes

- This slice carries the batch CRISPR-facing post-apply artifact across the
  same transport boundary used by the single line.
