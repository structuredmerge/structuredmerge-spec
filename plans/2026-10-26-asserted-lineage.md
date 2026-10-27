# Plan: asserted occurrence lineage — 2026-10-26

Slice 1053 under [plans #6](https://github.com/structuredmerge/plans/issues/6).

## Scope

Spec-only increment: the typed lineage assertion mechanism. Per slice 1052, specified against the v2 identity model with zero dialect-preservation constraints; the issue's compatibility packaging is superseded and ignored.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: `lineage` field row, "Asserted occurrence lineage" section, corpus list/coverage/preamble.
2. `slices/slice-1053-asserted-lineage.md`.
3. Fixtures: `diagnostics/slice-1053-asserted-lineage/contract.json` (6 positives, 4 negatives); validator `lineage` rules.

## Verification

Validator unit tests 12/12 across all eight corpora (1045–1051 unchanged); validator 99% lines (remainder is the `__main__` guard). Generator pitfall fixed along the way: `chunks_jsonl` carries ALL current rows, `upserts_jsonl` only added/updated — first corpus exercising a touched/added mix.

## Follow-ups

plans #7 (incorporation decisions ledger) is the last open issue.
