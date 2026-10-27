# Slice 1054 — Incorporation decisions

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Incorporation decisions"; optional `incorporation` field)
- **Tracking:** [plans #7](https://github.com/structuredmerge/plans/issues/7) (P1 / deferred slice — the last open issue)
- **Depends on:** #3, #5 (closed)
- **Supersedes:** the issue's legacy-preservation "alternatives" framing (moot per slice 1052)

## Problem

`evidence_refs` could point at decision/preservation artifacts but the contract had no shape for the decisions themselves: what was considered, what happened to it, and who decided. Everything since 1045 deferred to "the ledger (plans #7)".

## Contract changes

1. Optional `incorporation` array: decision records with `decision_id` (unique per payload, namespaced by producer+scope), `authority_ref`, `source_refs` (considered inputs — occurrences in the verified prior), `subject_refs` (decided-upon outputs — occurrences in the current delta), `outcome`, `evidence_refs` (⊆ payload `evidence_refs`).
2. Outcomes: `accepted`/`rejected`/`edited` (require nonempty subject), `ignored` (intentionally not incorporated) and `unknown` (unresolved) — empty subjects allowed as explicit records of inaction/uncertainty.
3. **Decision IDs are distinct from job/review status**; no decision implies execution success, and no job status implies outcomes.
4. **No-content decisions are first-class**: an accepted record over equal-content occurrences proves consideration, not silent dropping; absent output bytes never imply rejection or ignored intent; absent records mean "not recorded", never "no decisions occurred" — coverage limits stated explicitly.
5. Validation (`incorporation`): shapes, enums, uniqueness, prior/current membership, evidence declaration, outcome/subject rules. Durable storage stays with the ledger.

## Shared examples

`diagnostics/slice-1054-incorporation-decisions/contract.json` — ten cases: equal-content accepted (unchanged-but-considered), rejected, unknown, intentionally-ignored with empty subject, multiple decisions; negatives for subject/source membership, undeclared evidence, duplicate decision IDs, accepted-without-subject.

## Non-goals

No durable ledger implementation (this is the handoff shape), no job/review integration, no inference. Runtime adoption requires separate approval.
