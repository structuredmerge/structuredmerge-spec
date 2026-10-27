# Plan: tombstones, atomicity and compatibility — 2026-10-26

Slice 1050 under [plans #9](https://github.com/structuredmerge/plans/issues/9).

## Scope

Spec-only increment: derived tombstone records, application rollback semantics, and exact-version compatibility rules. Audit showed the remaining #9 criteria (companion envelope, dialect preservation, cross-document scoping, no-effects-on-failure) already specified by slices 1045–1046; this slice delivers the true delta and names the overlap in its PR.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: "Tombstone records, application atomicity and compatibility" section; corpus list/coverage.
2. `slices/slice-1050-tombstones-atomicity-compatibility.md`.
3. Fixtures: `diagnostics/slice-1050-tombstones-atomicity-compatibility/contract.json`; validator decision gains derived `tombstones`; harness tombstone assertions; overlapping-delete rejection case.

## Verification

Validator unit tests 12/12 across all six corpora (1045–1049 unchanged except the two deletion cases gaining tombstone expectations); validator 99% lines (remainder is the `__main__` guard).

## Follow-ups

Remaining open: #6/#7 (deferred ledger slices), #11 (retention). All P0/P1 observation-family criteria are now specified.
