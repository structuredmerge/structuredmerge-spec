# Plan: temporal semantics, dedupe and preconditions — 2026-10-26

Slice 1048 under [plans #8](https://github.com/structuredmerge/plans/issues/8).

## Scope

Spec-only increment closing plans #8's acceptance criteria: source time intervals with clock-trust rules, payload-bound dedupe definition, the no-advance re-observation rule (fixing a contract/validator inconsistency), reconciliation policy and atomic event visibility.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: `source_time_start`/`source_time_end` field row; rewritten "Retry, revision and time semantics"; preamble optional-fields note; corpus list/coverage.
2. `slices/slice-1048-temporal-dedupe-preconditions.md`.
3. Fixtures: `diagnostics/slice-1048-temporal-dedupe-preconditions/contract.json` (3 standalone cases + 2 sequences); validator interval rules, projection-evidence reuse check, vacuous chain edge.

## Verification

Validator unit tests 12/12 across all four corpora (1045–1047 unchanged); new code fully covered (validator 98% lines, remainder is the `__main__` guard).

## Follow-ups

plans #9 (tombstones/migration/compat) and #10 (embedding reuse) are the remaining open P1s besides the deferred #6/#7 ledger slices.
