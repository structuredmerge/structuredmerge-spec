# Slice 622: Structured Edit Provider Execution Receipt Replay Workflow Apply Result Transport Envelope

## Goal

Standardize one portable transport envelope for a provider execution receipt
replay-workflow apply-result record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-result transport
envelope:

1. the envelope kind is
   `structured_edit_provider_execution_receipt_replay_workflow_apply_result`,
2. the envelope version is `1`,
3. the envelope payload is one shared provider execution receipt replay-workflow
   apply-result record.

## Notes

- This slice keeps the CRISPR-facing post-apply artifact portable without
  flattening its nested apply-session or workflow-result state.
