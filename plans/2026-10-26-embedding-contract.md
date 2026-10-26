# Plan: embedding contract handoff — 2026-10-26

Slice 1049 under [plans #10](https://github.com/structuredmerge/plans/issues/10).

## Scope

Spec-only increment: define the embedding-contract identity handoff on the ingest-observation envelope and the attribution-not-attestation boundary. No runtime changes.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: `embedding_contract` field row, "Embedding contract handoff" section, processing-proof deferral rewritten to point at it, corpus list/coverage/preamble updates.
2. `slices/slice-1049-embedding-contract-handoff.md`.
3. Fixtures: `diagnostics/slice-1049-embedding-contract-handoff/contract.json` (1 negative + 3-step chain); validator `embedding` shape rules.

## Verification

Validator unit tests 12/12 across all five corpora (1045–1048 unchanged); new code fully covered (validator 99% lines, remainder is the `__main__` guard).

## Follow-ups

plans #9 (tombstones/migration) is the remaining substantive P1 besides deferred #6/#7 and retention #11.
