# Plan: evidence retention and reference integrity — 2026-10-26

Slice 1051 under [plans #11](https://github.com/structuredmerge/plans/issues/11).

## Scope

Spec-only increment: retained-evidence manifests, lifetime/downgrade semantics, and reproducible-vs-irrecoverable classification. Closes the last non-deferred issue in the observation family.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: "Evidence retention and reference integrity" section; byte-descriptor deferral rewritten to point at it; corpus list/coverage; remaining-gates list updated.
2. `slices/slice-1051-evidence-retention-integrity.md`.
3. Fixtures: `diagnostics/slice-1051-evidence-retention-integrity/contract.json`; verifier decisions gain `retained_evidence`; harness manifest assertions; expired-reference sequence.

## Verification

Validator unit tests 12/12 across all seven corpora (1045–1050 unchanged); validator 99% lines (remainder is the `__main__` guard).

## Follow-ups

Only deferred ledger slices #6/#7 remain open in the plans tracker.
