# Slice 614: Structured Edit Provider Execution Receipt Replay Workflow Apply Session Transport Envelope

## Goal

Standardize one portable transport envelope for a provider execution receipt
replay-workflow apply-session record.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-session transport
envelope:

1. the envelope kind is
   `structured_edit_provider_execution_receipt_replay_workflow_apply_session`,
2. the envelope version is `1`,
3. the envelope payload is one shared provider execution receipt replay-workflow
   apply-session record.

## Notes

- This slice keeps the CRISPR-facing apply-session artifact portable without
  flattening its nested request or replay-session state.
