# Slice 1048 — Temporal semantics, payload-bound dedupe and revision preconditions

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` ("Retry, revision and time semantics" extended; optional `source_time_start`/`source_time_end`)
- **Tracking:** [plans #8](https://github.com/structuredmerge/plans/issues/8) (P1)
- **Depends on:** #2, #3, #4, #5 (all closed)

## Problem

Slice 1045 established the dedupe key, exact-retry replay, conflicting-reuse rejection and preconditions, but: the validator rejected *every* re-reference of a retained revision, contradicting the contract's allowance for a fresh observation of an unchanged projection; source time had no interval form; clock-trust and no-substitution rules were implicit; and atomic visibility was only stated for effects, not observation records.

## Contract changes

1. Optional `source_time_start`/`source_time_end` (both-or-neither, RFC 3339 UTC, `start <= end`); point source time stays `times.source_at`. Job/queue/processing clocks must never populate source times; unknown stays explicitly null.
2. **Re-observation rule**: a different `observation_id` may re-reference a retained revision only with identical projection evidence (legacy bytes, original, normalized, processing fingerprint); the head does not advance. Different evidence rejects (`revision`). Chain-edge ancestry is vacuous when the expected prior equals the re-referenced revision.
3. Dedupe hash domain stated explicitly: exact payload bytes, no canonicalization.
4. Late/out-of-order rejects on preconditions; the only reconciliation is a fresh observation declaring the correct prior — no force-accept mode.
5. Atomic event visibility: no head advancement, replay entry or revision record commits unless every proof passes.

## Shared examples

`diagnostics/slice-1048-temporal-dedupe-preconditions/contract.json` — negatives (inverted interval, half-present interval, projection-evidence revision reuse via a two-step sequence) and positives (interval accepted; unknown source time stays unknown; unchanged-content no-advance re-observation; the same observation identity in another scope verifying independently). Validator enforcement added: interval pair rules, projection-evidence reuse check, vacuous chain edge on re-observation.

## Non-goals

No clock synchronization, distributed queue, durable event store, or per-scope state partitioning in the fixture model (the shared validator keeps a single global head per state). Runtime adoption requires separate approval.
