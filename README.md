# StructuredMerge Spec

Language-neutral specification work for StructuredMerge.

StructuredMerge defines portable rules, result shapes, diagnostics, and review/replay vocabulary for tools that merge structured documents. The spec is designed to be consumed by multiple peer implementations rather than owned by any one language runtime.

Project links:

- Website: <https://structuredmerge.org>
- Spec summary: <https://structuredmerge.org/spec.html>
- Conformance model: <https://structuredmerge.org/conformance.html>
- Shared fixtures: <https://github.com/structuredmerge/structuredmerge-fixtures>
- Peer implementations: [Go](https://github.com/structuredmerge/structuredmerge-go), [TypeScript](https://github.com/structuredmerge/structuredmerge-typescript), [Rust](https://github.com/structuredmerge/structuredmerge-rust), [Ruby](https://github.com/structuredmerge/structuredmerge-ruby)

## Core documents

- `MERGE_RULESET_INFORMATIONAL_DRAFT_02.md` — active informational draft for the merge ruleset vocabulary.
- `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md` — published baseline retained for stable reference.
- `merge-lexicon.md` — portable terminology snapshot derived from the active draft.
- `LORA_MERGE.md` — secondary application note for merge-like workflows above specialized backends.
- `RAG_INGESTION_ADAPTER_CONTRACT.md` — JSONL/delta/metric contract for stable RAG ingestion handoffs.
- `RAG_PILOT_PACKET_CONTRACT.md` — v1 customer pilot packet for RAG ingestion deliverables.
- `PGVECTOR_PLAN_CONTRACT.md` — v1 pgvector/PostgreSQL load-plan contract for RAG chunks.
- `PLANNER_PAYLOAD_CONTRACT.md` — v1 payload contract for AI planners and future MCP bindings.
- `PATCH_ARTIFACT_CONTRACT.md` — v1 patch artifact contract for non-mutating apply results.

## Slices

The `slices/` directory breaks the contract into implementation-facing increments. Early slices cover foundation types, diagnostics/results, plain text analysis, JSON/JSONC parsing, similarity, parser adapters, structural analysis, owner matching, and merge resolution. Later slices capture backend and family substrate boundaries.

## Relationship to fixtures

The spec names the vocabulary and expected shapes. The fixture corpus turns that vocabulary into runnable cases that each implementation can consume. A behavior is portable only when it can be expressed through the shared contract and exercised by shared fixtures.

## Implementation Alignment

Implementation status is represented by runnable fixture coverage, slice plans,
and package tests in the implementation repositories. This repo should not carry
a static product-status document; those documents age poorly and drift away from
the actual product surfaces.

## Non-goals

- Defining one universal merge algorithm.
- Treating one language implementation as canonical.
- Storing language-specific package planning here.
- Replacing review with silent automatic conflict resolution.

## Tooling

- `tools/ast_merge_fixture_key_parity.py` — reports shared diagnostic fixture-key coverage across TypeScript, Go, Rust, and Ruby host tests.
- `tools/family_package_fixture_key_parity.py` — reports family-package fixture slice coverage across TypeScript, Go, Rust, and Ruby host tests.
- `tools/provider_package_fixture_key_parity.py` — reports provider-package fixture slice coverage across TypeScript, Go, Rust, and Ruby host tests.
- `tools/provider_matching_assertion_audit.py` — reports whether provider matching-fixture tests assert unmatched paths as well as matched pairs.
- `tools/provider_backend_override_audit.py` — reports whether provider packages test unsupported backend override rejection across hosts.
