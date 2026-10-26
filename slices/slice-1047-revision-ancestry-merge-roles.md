# Slice 1047 — Revision ancestry and merge-role links

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Revision ancestry and merge-role links"; optional `revision_parents` payload field)
- **Tracking:** [plans #5](https://github.com/structuredmerge/plans/issues/5) (P1)
- **Depends on:** #3, #4 (closed)

## Problem

The contract had immutable `revision_ref` identities and a verified chain edge (`expected_prior_revision_ref`) but no declared ancestry, no merge-parent records, and no rule binding merge roles (base/ours/theirs, incoming/current) to durable revision references. Version counters and storage delta bases were the only ordering signals — and are not ancestry.

## Contract changes

1. Optional `revision_parents` payload field: absent = ancestry not declared (uncertainty retained); `[]` = declared root; nonempty = declared parents that MUST include the expected prior when non-null (the verified chain edge).
2. Validation (named reason `ancestry`): nonempty unique strings, no self-reference, root/prior contradiction, missing chain-edge parent. External/unresolvable parents retained verbatim as declared-but-unverified. Precondition checks always dominate ancestry.
3. Merge roles bind to declared parent revision references — never request IDs, transport labels or AST parents; role assignment may ride in `extensions`; durable role-link storage deferred to #6/#7.
4. Content-equal revisions with distinct provenance are distinct revisions; digests never collapse identity.

## Shared examples

`diagnostics/slice-1047-revision-ancestry-merge-roles/contract.json` — six negative cases (missing chain parent, self-parent, declared root with prior, duplicate parents, non-string parent, late import with declared parents) and one four-step chain sequence (undeclared-ancestry initial → linear parent → multi-parent merge with an external parent → content-equal distinct revision), all through the shared validator, which gained the `ancestry` rules.

## Non-goals

No branch/remote model, VCS storage, patch reconstruction, graph service, or durable ledger — those stay with #6/#7 and later design. Runtime adoption requires separate approval.
