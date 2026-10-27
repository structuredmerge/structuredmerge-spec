# Slice 1050 — Tombstone records, application atomicity and compatibility

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Tombstone records, application atomicity and compatibility")
- **Tracking:** [plans #9](https://github.com/structuredmerge/plans/issues/9) (P0 safety / P1 rollout)
- **Depends on:** #2, #4, #8 (all closed)

## Problem

Plans #9 asked for five things. Audited as already specified by earlier slices: the opt-in companion envelope binding the unmodified legacy payload per dialect (1045), legacy ID/ordinal/type/queue preservation without opt-in (1045 "Legacy dialect preservation"), cross-document collision scoping (1046), and no-effects-on-failure (asserted per negative case since 1045). The true delta: derived tombstone records with cause/observation/authority binding, application rollback semantics, and version negotiation.

## Contract changes

1. **Tombstone records**: applying an authorized deletion derives `{scope, target, prior_revision_ref, cause (deletion mode), authorizing observation_id + revision_ref, authority_ref}` per target. Occurrence-scoped; bare legacy IDs are never tombstone keys; cross-document collisions resolve by scope; `none` derives nothing; undeletion is a fresh initial observation.
2. **Application atomicity/rollback**: all-or-nothing per observation; failure leaves no partial upserts/tombstones and does not consume the observation — retry is exact-retry replay, different bytes are conflicting reuse.
3. **Version negotiation**: exact-version `schema` matching; unknown versions and unknown fields reject, never partial-parse or silent drop; no in-envelope feature negotiation; legacy bytes round-trip unchanged and opt-in changes nothing for legacy-only consumers.

## Shared examples

`diagnostics/slice-1050-tombstones-atomicity-compatibility/contract.json` — the two 1045 deletion cases now assert full derived tombstone records; a new overlapping-upsert/delete case rejects (`delta`). Validator decision gains `tombstones`; harness compares them when expected.

## Non-goals

No importer/schema changes, migration execution, or automatic v1 rewrite — the reviewed compatibility/migration contract plus fixtures is the gate. Runtime adoption requires separate approval.
