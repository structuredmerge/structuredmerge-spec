# Slice 1055 — Residue interleaving

- **Status:** Proposed
- **Parent contract:** `RAG_INGESTION_ADAPTER_CONTRACT.md` (new section "Residue Interleaving")
- **Tracking:** [plans #13](https://github.com/structuredmerge/plans/issues/13) (P1)

## Problem

Parsers strip or skip regions of documents (comments in data formats, unknown constructs, embedded blobs). At the ingest boundary those regions were silently dropped: since the sidecar's data-family surfaces became comment-free (ur_brain-sm-rust#2), JSONC comment content exists in no stored chunk and is unreachable by semantic search. More generally, any parser-discarded content is invisible to chunk identity and retrieval, with no contract saying what must happen to it.

## Contract changes

Adds "Residue Interleaving" to `RAG_INGESTION_ADAPTER_CONTRACT.md`:

1. **No silent loss**: every byte span the primary parser does not own either appears in an interleaved chunk or is an explicitly declared drop with a reason.
2. **Detection-selected fallback tiers**: `comment` (shared comment machinery), `plain` (line-based), or a nested format parser — including non-line-based parsers (binary streams). Declared per chunk via `residue_parser`.
3. **Interleaved surfaces**: standard chunk objects in the document's single ordinal stream, carrying `surface_kind: <family>_residue` and `parent_address` (nearest following owned surface; trailing residue attaches to the last owned surface).
4. **Identity invariant**: residue `content_hash` covers residue text only; identical owned text yields identical owned hashes regardless of residue; a residue-only edit changes exactly the covered residue chunks and no owned chunk.

## Design notes

- Precedent: markdown code fences already interleave delegated parsers (`/markdown/code_fences/` surfaces with `declared_language`/`delegated_family`).
- Comment detection and owner attachment reuse `ast-merge/src/comment.rs` (`TrackedComment`, `augment_normalized_comments_with_owners`) — no second comment model.
- Merge behavior is explicitly out of scope; json-merge's comment-preserving normalization stands.

## Shared examples

`diagnostics/slice-1055-residue-interleaving/contract.json` in the fixtures repository, checked by the parser-free residue validator (`tools/validate_residue_chunks.py`):

- `jsonc-comment-only-edit-preserves-owned-identity` (verified) — two ingest outputs differing only in comments carry identical owned hashes; exactly one residue chunk differs
- `comment-attaches-to-nearest-following-surface` (verified) — `parent_address` resolves to an owned surface address
- `trailing-comment-attaches-to-last-surface` (verified)
- `string-containing-comment-syntax-is-not-residue` (verified) — comment-shaped string content stays inside its owned chunk
- `undetected-residue-falls-back-to-plain-tier` (verified) — `residue_parser: "plain"`
- `residue-silent-drop-rejected` (rejection) — an uncovered span with no declared drop
- `residue-missing-parent-address-rejected` (rejection)
- `residue-edit-changing-owned-hash-rejected` (rejection) — the core invariant, cross-checked between variant cases

## Runtime follow-through

First implementation slice: JSONC comments in the sidecar data family (`strip_jsonc_comments` becomes the comment-tier scanner; spans already preserved). Runtime work proceeds under its own approval per the plans convention.
