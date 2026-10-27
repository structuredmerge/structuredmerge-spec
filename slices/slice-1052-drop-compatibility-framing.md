# Slice 1052 — Drop compatibility and legacy framing

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (terminology and framing pass; no behavioral change)
- **Tracking:** decision recorded in [plans #1](https://github.com/structuredmerge/plans/issues/1) discussion; affects [#6](https://github.com/structuredmerge/plans/issues/6) and [#7](https://github.com/structuredmerge/plans/issues/7)
- **Depends on:** none

## Problem

The contract inherited the audit's compatibility framing: "legacy dialect preservation" obligations, "legacy-only consumers remain unchanged", "old client/new companion" style guarantees. None of it corresponds to reality — nothing in this family has ever been deployed, there are no consumers to stay compatible with, and the implemented v2 stack is already a clean break. The framing invited wasted work reasoning about obligations that do not exist.

## Changes

Terminology and framing pass only; validator, corpora and all wire identifiers unchanged:

1. New status rule: **no compatibility obligations** — surviving "legacy" naming in JSON identifiers (`legacy_result`, `legacy_schema_ref`, `legacy-result-json`, dialect identifiers) is historical, not obligation.
2. "Legacy dialect preservation" → "Delta result dialects": dialects described as reference shapes for validation, explicitly never deployed, with no preservation duties.
3. Removed: legacy-consumer guarantees, "no new schema field inserted", "retains existing fields", "opt-in changes nothing for them", adoption-as-migration framing.
4. Vocabulary: legacy result → delta result; legacy ID → delta ID; companion → observation envelope. ID-scheme opacity and scope-complete predicate rules kept (correctness, not compatibility).
5. "Tombstone records, application atomicity and compatibility" → "…and application atomicity"; the exact-version schema rule stays (integrity, not compat).

## Non-goals

No wire-format renames (`legacy_result` and friends keep their names — renaming would churn every corpus for zero value). No behavior change; all seven corpora pass unchanged.
