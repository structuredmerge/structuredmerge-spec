# Slice 637: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Outcome

## Goal

Standardize one replay-workflow apply-decision outcome record built from a
provider execution receipt replay-workflow apply decision.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision outcome
contract:

1. the apply-decision outcome carries one shared provider execution receipt
   replay-workflow apply-decision record,
2. the apply-decision outcome carries one stable `outcome` value,
3. apply-decision outcome metadata may remain visible without changing the
   nested replay-workflow apply-decision artifact.

## Notes

- This slice is the first CRISPR-facing post-decision outcome surface built on
  top of the replay-workflow apply-decision line.
