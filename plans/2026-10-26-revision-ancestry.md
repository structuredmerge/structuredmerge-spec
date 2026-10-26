# Plan: revision ancestry and merge-role links — 2026-10-26

Slice 1047 under [plans #5](https://github.com/structuredmerge/plans/issues/5).

## Scope

Spec-only increment: declared revision ancestry (`revision_parents`), merge-role binding rules, and shared validator enforcement. No runtime adapter changes; no workflow edits.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: `revision_parents` field row, "Revision ancestry and merge-role links" section, corpus list/coverage updates, required-fields preamble exception note.
2. `slices/slice-1047-revision-ancestry-merge-roles.md`.
3. Fixtures: `diagnostics/slice-1047-revision-ancestry-merge-roles/contract.json` (6 negatives + 4-step chain sequence); validator `ancestry` rules; harness per-step sequence contexts and third corpus.

## Verification

Validator unit tests 12/12 across all three corpora; new ancestry code fully covered (validator at 98% lines, remainder is the `__main__` guard); all 1045/1046 cases unchanged and passing.

## Follow-ups

- plans #8 (temporal/dedupe/preconditions) is now unblocked: its dependency set (#2, #3, #4, #5) is closed, with #5 reference/coverage decisions made here.
- Durable role-link/lineage storage deferred to #6/#7.
