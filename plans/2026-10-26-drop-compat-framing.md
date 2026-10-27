# Plan: drop compatibility and legacy framing — 2026-10-26

Slice 1052. Decision: backwards compatibility and legacy are strict non-issues — nothing in this family has ever been live, so the contract stops considering them.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: status note declaring no compatibility obligations and historical-only "legacy" naming; dialect section reframed as reference shapes; legacy-consumer/adoption-migration guarantees removed; vocabulary pass (delta result/delta ID/observation envelope). No wire-identifier renames, no behavioral change.
2. `slices/slice-1052-drop-compatibility-framing.md`.
3. Supersession comments on plans #6 and #7: their "Alternatives Considered" legacy-preservation framing is moot; upcoming slices specify against the v2 identity model.

## Verification

Validator unit tests 12/12 across all seven corpora — unchanged, confirming the reframe is prose-only.
