# Slice 672: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Audit Record Envelope Application

## Goal

Standardize envelope application for one replay-workflow apply-decision
audit-record.

## Shared Behavior

This slice defines one shared replay-workflow apply-decision audit-record
envelope application:

1. importing a supported envelope returns one shared provider execution
   receipt replay-workflow apply-decision audit-record,
2. the applied audit-record remains structurally identical to the shared
   nested closure-report artifact it carries,
3. the same rejection cases from the transport rejection slice remain
   unchanged during application.

## Notes

- This slice keeps the final audit artifact runnable through the shared
  transport boundary.
