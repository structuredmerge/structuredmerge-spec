# Slice 1046 — Document identity, namespace and occurrence scoping

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Document identity, namespace and rename/alias semantics")
- **Tracking:** [plans #4](https://github.com/structuredmerge/plans/issues/4) (P1); extends slice 1045 ([plans #12](https://github.com/structuredmerge/plans/issues/12))
- **Depends on:** #2, #3 (closed)

## Problem

Slice 1045 defined the occurrence reference and demonstrated duplicate chunks, equal text in two documents, and prepend/reorder without lineage. It did not define: canonical document identity versus source reference, workspace namespace ownership, rename/alias behavior, or the storage-predicate prerequisites adapters must satisfy before adopting scoped occurrences (audit finding E-series in plans #4).

## Contract changes

Adds a dedicated section to `INGEST_OBSERVATION_CONTRACT.md`:

1. `workspace_id` names a document namespace; `document_id` is the canonical immutable document identity within it; `source_id` is a source-system reference/alias. Alias sets are trusted external context, never payload-asserted.
2. Full-scope matching means a renamed source is a new observation scope whose first delivery is initial (null expected prior), even with unchanged `document_id`. Continuity across rename requires externally trusted alias evidence; `extensions` assertions authorize nothing. Cross-scope prior inventories reject (`prior`), including under a consumer that mistakenly carried the old head.
3. Namespaces are disjoint: same `source_id`/`document_id` in two workspaces are independent documents. Deletion targets never cross scope by content or ID equality; embedding sharing is policy (#10), not identity.
4. Adoption prerequisites: legacy ID schemes carried verbatim; bare-ID storage predicates must be proven scope-complete or the adapter refuses opt-in; duplicate IDs/ordinals in a prior inventory reject (`delta`).

## Shared examples

`diagnostics/slice-1046-document-identity-occurrence-scoping/contract.json` in the fixtures repository — six designed cases, all exercised through the unchanged shared validator:

- `rename-fresh-scope-initial` (verified) — same workspace/document, new `source_id`: initial delivery, no prior
- `rename-cross-scope-prior-rejected` (`prior`) — old scope's inventory/head carried into the renamed scope
- `extension-alias-cannot-bridge-scope` (`prior`) — rename asserted in `extensions` still cannot chain
- `same-source-second-workspace-initial` (verified) — identical source/document IDs in another workspace: independent namespace
- `equal-text-distinct-document-initial` (verified) — identical chunk text and hosted IDs under a second document: distinct occurrences
- `duplicate-ordinal-in-prior-inventory` (`delta`) — ordinal reuse within one inventory

## Non-goals

No runtime adapter changes, no alias-ledger design (later slices), no rename inference, no embedding policy. Runtime adoption requires separate approval per the parent contract's status.
