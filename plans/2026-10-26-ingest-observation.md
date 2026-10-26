# Ingest Observation Implementation Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Specify and exercise the smallest opt-in observation/deletion-authority companion, prioritizing structuredmerge/plans#2 and #3 under #12.

**Architecture:** Retain both legacy results byte-for-byte. A versioned companion binds exact result bytes, document-chunk enumeration scope, recoverable original/normalized bytes, processing identity and externally verified deletion authority. Shared fixture validation is not an adapter implementation or runtime conformance claim.

**Tech Stack:** Markdown specification; language-neutral JSON examples; Python standard-library validator and unittest, following existing fixtures/tools discovery.

---

## Preconditions and allocation

Read the complete 2026-10-23 local history audit, plans issues #1/#2/#3/#12, workspace guidance, both READMEs and CI workflows, RAG/pgvector contracts and recent portable envelope/preservation slices. Neither owning repository has local AGENTS/contribution/templates; inherited organization .github has no contribution or PR template. Main revisions are spec `1f5193825998f9ff231fce6b3c1c2be44b6e8493` and fixtures `d3702f87f1f5fa1f443b19c2eaf50fc804cb0bef`, also returned by SSH remote main lookup. Slice 1045 has no worktree collision in either repository; reserve it on `feat/plans-12-ingest-observation` in each repo. Existing duplicate 1038 names are unrelated; do not renumber them.

### Task 1: Specify companion and compatibility gate

**Objective:** Define evidence and authorization without changing legacy consumers.

**Files:** Create `INGEST_OBSERVATION_CONTRACT.md`, `slices/slice-1045-ingest-observation-deletion-authority.md`; modify `README.md`, RAG/pgvector cross-references and tool-managed Unreleased changelog.

1. Define version, exact-byte result descriptor/dialect, workspace/source/document scope, separate observation/revision/source/prior references.
2. Require retrievable original bytes and normalized digest, versioned processing descriptor/fingerprint and explicit parser not-applicable/unknown states.
3. Define no authority, complete-finalized same-scope absence authority, and explicit-source tombstone authority separately; external authority never derives from self-asserted fields.
4. Bind retry identity to complete payload; reject unexpected prior; unknown evidence never authorizes deletion. Keep temporal semantics and evidence pointers minimal.
5. Validate slice headings/Markdown and `git diff --check`; commit only named spec files with issue references.

### Task 2: Exercise a minimal fixture validator vertically

**Objective:** Prove descriptor and payload verification before deletion rules.

**Files (fixtures repo):** Create `diagnostics/slice-1045-ingest-observation-deletion-authority/{README.md,contract.json}`, `tools/validate_ingest_observations.py`, `tools/test_validate_ingest_observations.py`.

1. Write a descriptor/retry digest test first; run `python3 -m unittest discover -s tools -p 'test_validate_ingest_observations.py'` and observe missing implementation failure.
2. Add strict JSON/exact-byte descriptor validation and payload digest; rerun to green.
3. Add failing scope/completeness/explicit-authority tests, then minimal contract checks; rerun to green. No runtime, database or network fetch in this validator.
4. Add shared positive/negative cases and replay sequences for unknown/partial/interrupted/empty, scoped prior validation, tombstones, unavailable/wrong bytes, processing mismatch, duplicates, ordinal churn, reprojection and both dialects. Test acceptance/rejection codes, not just JSON parsing.
5. Bind fixture expectations to explicit authorized IDs and assert original legacy bytes remain unchanged.

### Task 3: Verify, document and commit fixture artifact

**Objective:** Leave reproducible verified contract artifacts, not claimed runtime support.

**Files:** Modify fixtures `README.md` and tool-managed Unreleased changelog. Existing CI unittest discovery already runs the new regressions; no workflow edit is required.

1. Run `python3 tools/validate_ingest_observations.py` and `python3 -m unittest discover -s tools -p 'test_*.py'`.
2. Run existing `python3 tools/validate_provider_snapshots.py`, all tracked JSON parsing, manifest-path validation and both repos' whitespace checks; report unrelated failures accurately.
3. Review staged scope and commit separately with references to plans #12/#2/#3. Do not close issues; runtime adapter choice, authenticated evidence resolvers, scoped storage migration, atomicity/ordering, retention, embedding and rollout remain unimplemented.
4. PR publication is a separate parent-agent coordination step after current guidance/template checks; no PR or issue update is necessary for local artifact delivery.
