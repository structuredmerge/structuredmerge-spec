# Slice 1053 — Asserted occurrence lineage

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Asserted occurrence lineage"; optional `lineage` field)
- **Tracking:** [plans #6](https://github.com/structuredmerge/plans/issues/6) (P1 / deferred slice)
- **Depends on:** #4, #5 (closed); #7 referenced for durable lineage storage only
- **Supersedes:** the issue's legacy-preservation "alternatives" framing (moot per slice 1052)

## Problem

The contract established that lineage is never *inferred* (prepend/reorder establishes nothing) but provided no way to *assert* it. Plans #6 asked for typed move/copy/split/join/reorder relationships with provenance, explicit uncertainty, and a distinction between authored split/join and rechunking.

## Contract changes

1. Optional `lineage` array: typed assertions (`move`/`copy`/`split`/`join`/`reorder`, many-to-many) between prior-revision and current-revision occurrences. Assertions are evidential — they never convert remove+add into update or authorize effects; absence asserts nothing.
2. Provenance per assertion: `basis` (authored/algorithmic/unknown), `authority_ref` (required when authored; external validation is trusted context), `algorithm` id+version (required when algorithmic), `confidence` in [0,1]. Rechunking needs no assertion — authored split/join is an intent claim.
3. Status `asserted`/`ambiguous`/`unknown`: asserted requires nonempty sides and membership (`from` in the verified prior inventory, `to` in the current delta result); `reorder` requires equal content-hash multisets (ordinal-coupled ID schemes mint new IDs on movement); ambiguous/unknown may carry empty sides — explicit uncertainty beats invented edges.
4. Durable reorder is an assertion, not ordinal churn. Durable lineage storage stays with the ledger (#7).

## Shared examples

`diagnostics/slice-1053-asserted-lineage/contract.json` — ten cases: asserted move; equal-content independent re-entry (no assertion) vs asserted copy; authored split; durable reorder with equal hash multisets; ambiguous with empty side; negatives for prior membership, reorder content inequality, authored-without-authority, and asserted-empty-sides. Validator gains the `lineage` rules.

## Non-goals

No inference algorithms, no lineage-driven effects, no durable ledger (#7). Runtime adoption requires separate approval.
