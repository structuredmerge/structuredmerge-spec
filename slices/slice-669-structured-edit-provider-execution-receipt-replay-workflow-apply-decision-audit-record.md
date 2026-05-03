# Slice 669: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Audit Record

## Goal

Standardize one replay-workflow apply-decision audit-record built from a
provider execution receipt replay-workflow apply-decision closure-report.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
audit-record contract:

1. the audit-record carries one shared provider execution receipt
   replay-workflow apply-decision closure-report,
2. the audit-record carries one stable `audit_record` value,
3. audit-record metadata may remain visible without changing the nested
   replay-workflow apply-decision closure-report artifact.

## Notes

- This slice keeps the `ast-crispr` end state in view by turning the closure
  report into a final reusable audit artifact rather than stopping at closure
  transport.
