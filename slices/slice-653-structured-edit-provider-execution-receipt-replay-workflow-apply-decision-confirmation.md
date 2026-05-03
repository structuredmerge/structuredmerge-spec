# Slice 653: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Confirmation

## Goal

Standardize one replay-workflow apply-decision confirmation record built from
a provider execution receipt replay-workflow apply-decision settlement.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
confirmation contract:

1. the apply-decision confirmation carries one shared provider execution
   receipt replay-workflow apply-decision settlement record,
2. the apply-decision confirmation carries one stable `confirmation` value,
3. apply-decision confirmation metadata may remain visible without changing
   the nested replay-workflow apply-decision settlement artifact.

## Notes

- This slice is the next CRISPR-facing closure surface built on top of the
  replay-workflow apply-decision settlement line.
