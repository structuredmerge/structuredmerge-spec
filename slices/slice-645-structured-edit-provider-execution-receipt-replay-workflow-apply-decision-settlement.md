# Slice 645: Structured Edit Provider Execution Receipt Replay Workflow Apply Decision Settlement

## Goal

Standardize one replay-workflow apply-decision settlement record built from a
provider execution receipt replay-workflow apply-decision outcome.

## Shared Behavior

This slice defines one shared receipt replay-workflow apply-decision
settlement contract:

1. the apply-decision settlement carries one shared provider execution receipt
   replay-workflow apply-decision outcome record,
2. the apply-decision settlement carries one stable `settlement` value,
3. apply-decision settlement metadata may remain visible without changing the
   nested replay-workflow apply-decision outcome artifact.

## Notes

- This slice is the first CRISPR-facing post-outcome closure surface built on
  top of the replay-workflow apply-decision outcome line.
