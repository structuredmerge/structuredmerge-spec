# Slice 670: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Audit Record Transport Envelope

## Goal

Standardize transport for one replay-workflow apply-decision audit-record.

## Shared Behavior

This slice defines one shared replay-workflow apply-decision audit-record
transport envelope:

1. the envelope kind is
   `structured_edit_provider_execution_receipt_replay_workflow_apply_decision_audit_record`,
2. the envelope version is the shared structured-edit transport version,
3. the envelope payload carries one shared provider execution receipt
   replay-workflow apply-decision audit-record.

## Notes

- This slice keeps the final audit artifact portable without changing the
  nested closure-report record.
