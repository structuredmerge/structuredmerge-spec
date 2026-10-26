# Slice 1049 — Embedding contract handoff

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Embedding contract handoff"; optional `embedding_contract` field)
- **Tracking:** [plans #10](https://github.com/structuredmerge/plans/issues/10) (P1)
- **Depends on:** #3, #4, #8 (all closed)

## Problem

The contract twice deferred embedding policy to plans #10 ("neither touched chunks nor equal hashes establish embedding compatibility"; "whether equal content may share an embedding is policy, not identity") without defining the handoff itself: what identity a producer communicates, how unknown model revisions stay explicit, and why an observation can never attest vector currency.

## Contract changes

1. Optional `embedding_contract`: exact object with `owner`, `model_ref`, `model_revision` (null = explicitly unknown), `dimensions` (positive int or null), `normalization`, `instruction_profile`. Malformed shapes reject (`embedding`).
2. **Attribution, not attestation**: the handoff names the contract a projection assumes; it never claims stored vectors satisfy it and moves no generation/rebuild logic into this contract.
3. Content reuse stays distinct from vector compatibility: equal content + equal contract ≠ current vectors; changed contract over the same content may require regeneration; importer early-return on unchanged content MUST NOT be read as attesting current-contract vectors. Absence asserts nothing.

## Shared examples

`diagnostics/slice-1049-embedding-contract-handoff/contract.json` — malformed-contract rejection and a three-step chain: equal content under the same contract → equal content under a changed contract (new revision + dimensions) → explicitly unknown model revision. Validator gains the `embedding` shape rules.

## Non-goals

No embedding generation, storage, regeneration state machine, or rebuild orchestration — all remain with `owner`. Runtime adoption requires separate approval.
