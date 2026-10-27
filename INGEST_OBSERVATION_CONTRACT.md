# Ingest Observation and Deletion-Authority Contract

## Status and scope

Opt-in, spec-first boundary under [plans #12](https://github.com/structuredmerge/plans/issues/12), prioritizing [#2](https://github.com/structuredmerge/plans/issues/2) and [#3](https://github.com/structuredmerge/plans/issues/3).

**No compatibility obligations.** Nothing in this contract family has ever been deployed; there are no legacy consumers and no compatibility fallbacks. Surviving "legacy" naming in JSON identifiers (`legacy_result`, `legacy_schema_ref`, the `legacy-result-json` domain, dialect identifiers) is historical only — these are wire identifiers, not obligations. Dialects below are reference shapes used for validation, not things this contract preserves. Slice 1045 and its shared examples specify expectations, not implemented adapter support, authenticated evidence, deployed safety or runtime conformance. Runtime implementation and rollout require separate approval.

V1 enumerates **one document's chunks**, not every document in a workspace or source. Broader enumeration requires a new declared contract; this limit prevents a document-level empty result from becoming a source-wide delete. No VCS, lineage inference, blob service, database, crawler or embedding implementation is prescribed.

## Transport, exact bytes and verification

The observation envelope is separate from the delta result it evidences, never injected into it:

```json
{
  "schema": "structuredmerge.ingest-observation/v1",
  "payload_json": "{...}",
  "payload_digest": "sha256:<64 lowercase hex digits>"
}
```

`payload_json` is an exact UTF-8 JSON object string. Its digest covers those exact UTF-8 bytes, including whitespace, ordering and escapes; there is no JSON canonicalization. An identical retry reuses that string. A semantically equivalent reserialization is a different payload. Reject duplicate object keys, non-finite/non-JSON numbers, invalid UTF-8/unpaired surrogates, wrong types, missing required fields, unknown core fields/enums or unsupported schema versions. Retain namespaced opaque metadata only inside `extensions`; it cannot authorize anything. Extensions participate in the payload digest and survive round trips unchanged. Unknown evidence is not success and MUST NOT be replaced with invented defaults.

A **byte descriptor** has exactly `domain`, `byte_length` (nonnegative integer), `digest`, and exactly one of `inline_base64` or `ref`. Base64 is strict RFC 4648 standard alphabet with padding. `ref` is an immutable retrievable reference, not a mutable URL or digest alone. A verifier resolves it using an externally supplied resolver and checks exact length and SHA-256 of retrieved bytes before accepting the observation. Unavailable, expired or mismatching bytes reject verification and authorize no effects; preserve the failed observation separately if desired, never mark it verified. Retention obligations and evidence lifetime are specified in "Evidence retention and reference integrity".

Digests prove bytes, not authenticity or permission. Producer names, finalization refs and authority refs in the payload are assertions until checked against external trusted evidence. The fixture harness supplies local evidence/resolver context to test this boundary; it does not implement authentication or remote fetching.

## Required payload

All fields below are required (explicit null where stated); no omitted-field defaults. The exceptions are `revision_parents`, the `source_time_start`/`source_time_end` pair, and `embedding_contract`, whose omission is a distinct declared state (ancestry not declared; source interval not asserted; no embedding-contract handoff), not a default:

| Field | Meaning |
| --- | --- |
| `producer` | Object with nonempty `id`, `version`, `contract_ref`. An adapter contract identity, not an authenticated principal by itself. |
| `scope` | Object with nonempty `workspace_id`, `source_id`, `document_id`, and `enumeration: "document-chunks"`. Exact equality, no prefix/wildcard/alias matching. |
| `observation_id` | Opaque nonempty event identity scoped by producer ID and full scope. Not a content digest. |
| `revision_ref` | Opaque nonempty immutable inventory/projection revision reference in that scope. Never inferred from observation time or a chunk hash. |
| `source_revision_ref` | Nonempty source-system revision reference or null for unknown. Does not assert an ancestry edge. |
| `expected_prior_revision_ref` | Nonempty expected current revision, or null meaning expect no prior inventory. Required precondition, not a request to guess latest. |
| `prior_inventory` | Null exactly when expected prior is null; otherwise descriptor with domain `prior-inventory-json`. |
| `legacy_result` | Object with `dialect`, `schema_ref`, and `bytes` descriptor of domain `legacy-result-json` (names are historical). Binds the exact, unmodified serialized delta result bytes. |
| `original` | Descriptor of domain `original-source-bytes`; exact pre-normalization bytes including encoding/BOM/newlines/whitespace. For an explicit source deletion these are the last known prior source bytes, not invented empty current content. |
| `normalized` | Descriptor of domain `normalized-input-utf8`; exact normalized input bytes, distinct from chunk text and original bytes. Decode as strict UTF-8. For explicit deletion these describe the retained prior projection. |
| `processing` | Object with `descriptor` (domain `processing-json`) and `fingerprint`, equal to the verified descriptor digest. |
| `times` | Object with `source_at` (timestamp or null), `observed_at` and `processed_at` (timestamps). See temporal semantics. |
| `scan` | Object with `status`, `enumerated_scope`, `checkpoint_ref`, `finalization_ref`. |
| `deletion` | Object with `mode`, `authority_ref`, `targets`. |
| `evidence_refs` | Array of nonempty immutable pointers to available merge decision/preservation/role evidence; empty explicitly means none supplied. These pointers assert no full incorporation coverage or lineage. |
| `extensions` | Object for opaque namespaced metadata, retained exactly in payload bytes. |
| `revision_parents` | Optional. Duplicate-free array of nonempty declared parent revision references for this `revision_ref`. Absent means ancestry is **not declared** (uncertainty retained); `[]` means declared root; nonempty means declared parents which MUST include `expected_prior_revision_ref` when that is non-null. See revision ancestry. |
| `source_time_start` / `source_time_end` | Optional pair (both present or both absent). RFC 3339 UTC source-asserted interval bounds; `start <= end`. A point source time uses `times.source_at` instead. Never populated from job or processing clocks. |
| `embedding_contract` | Optional. Embedding-contract identity handoff: exact object with `owner`, `model_ref`, `model_revision`, `dimensions`, `normalization`, `instruction_profile`. See embedding contract handoff. |

A prior inventory is an exact JSON object with `scope`, `revision_ref`, and `chunks`. Each chunk is exactly `{ "id": <delta ID>, "ordinal": <nonnegative integer>, "content_hash": <digest> }`. IDs and ordinals are unique within this inventory; equal content digests at different ordinals are valid. Verify its descriptor, full scope and expected revision. A resolver must validate that this immutable inventory is the trusted current prior for this scope, not merely accept a self-asserted historical snapshot. The supplied delta result must use that same prior. Unknown prior/head rejects advancement; a late unexpected prior rejects without effects.

An occurrence reference is `(scope, revision_ref, delta chunk ID, ordinal)`. Document identity, observation identity, source revision, projection revision, content digest and occurrence are distinct. Equal text in two documents may have identical hosted delta IDs yet distinct scoped occurrences. Duplicate text in one revision remains multiple ordinal occurrences. Prepend/reorder does not establish copy/move intent or stable cross-revision occurrence continuity.

## Document identity, namespace and rename/alias semantics

`workspace_id` names a document namespace owned by an account/workspace boundary outside this contract; nothing here authenticates ownership. Within one workspace, `document_id` is the canonical immutable document identity and `source_id` is a source-system reference to it. One document may be reachable under several `source_id` values over its lifetime (rename, mount path, sync folder move); the set of valid aliases is trusted external context, never payload-asserted.

Because verification matches the full scope exactly (no prefix, wildcard or alias resolution), a renamed source is a **new observation scope**: its first observation is an initial delivery with null expected prior, even though `document_id` is unchanged. Continuity across a rename is established only by externally trusted alias evidence binding both `source_id` values to the same `document_id` in that workspace; an `extensions` entry asserting a rename is opaque metadata and authorizes nothing. A prior inventory whose scope differs from the envelope scope rejects (named reason `prior`), including when a consumer has mistakenly carried the old scope's trusted head into the new scope.

Namespaces are disjoint: the same `source_id` and `document_id` in two workspaces are two documents with independent heads, observations and revision chains. Equal chunk text under two scopes produces equal content digests and possibly equal hosted delta IDs, but distinct occurrences; deletion targets are always scoped and never cross a scope boundary by content or ID equality. Whether equal content may share an embedding is an embedding-policy decision (plans #10), not identity.

Delta ID schemes (including ordinal-bearing and source-ref-bearing IDs) are opaque to this contract: carried into inventories verbatim, never renumbered, rescoped or normalized. Storage predicates that look chunks up or delete them by bare delta ID (without full scope) must be scope-complete before applying authorized deletions, or the adapter must refuse application; a bare delta ID is not an occurrence and must not be used as a cross-scope delete key. Duplicate IDs or ordinals within one prior inventory reject (named reason `delta`).

## Revision ancestry and merge-role links

`revision_ref` identities are immutable and opaque. Ancestry is **declared, not inferred**: the optional `revision_parents` array records the producer's declared parent revisions for the current `revision_ref`. Absence of the field is not a claim of root or of anything else — it means ancestry was not declared, and verifiers retain that uncertainty rather than inventing edges. `[]` is an explicit root claim and is contradictory with a non-null `expected_prior_revision_ref`. Version counters, sequence numbers and storage delta bases are not ancestry; ordering is never implied by reference form.

Validation rules (named reason `ancestry`): parents are nonempty strings, duplicate-free, and never include the current `revision_ref` itself. When `expected_prior_revision_ref` is non-null it MUST appear among the declared parents — that is the verified chain edge. Every other declared parent is an assertion retained as **declared but unverified**: an unresolvable or external parent reference is kept verbatim, never resolved into an edge nor rejected. A declared root (`[]`) with a non-null expected prior rejects, as does a declared ancestry that omits the verified prior. Late or out-of-order deliveries still reject on the existing `precondition` check regardless of what ancestry they declare; ancestry never overrides preconditions, and stale source timestamps never override either.

A nonempty parent set beyond the chain edge records a merge. Merge roles bind to declared parent revision references, never to request IDs, transport labels or AST parents: `merge3` roles (`base`, `ours`, `theirs`) and `merge2` roles (`incoming`, `current`) map onto the declared parents of the result revision without relabeling the revision references themselves. Role assignment may be carried as namespaced `extensions` metadata (opaque to this contract); a role name is not a revision identity and authorizes nothing here. Durable role-link storage beyond the declaration is deferred with the ledger design (plans #6, #7).

Content-equal revisions with distinct provenance are distinct revisions: identical inventory bytes or chunk sets never collapse two `revision_ref` values, and a fresh observation may advance to a new revision whose content equals its prior (declared parent) — identity follows the revision reference and its declared ancestry, not the digest.

## Processing proof

The exact `processing-json` object has `schema: "structuredmerge.ingest-processing/v1"`, `normalizer`, `chunker`, `hash`, `parser` and `legacy_schema_ref`. Each normalizer/chunker is an object with nonempty `id`, `version` and explicit object `config` (including an empty object when no options apply). `hash` is exactly `{ "algorithm": "sha256", "domain": "chunk-text-utf8" }` in this version. `legacy_schema_ref` (historical name) must equal the delta result's declared schema reference.

`parser` is either `{ "status": "not_applicable" }`, `{ "status": "unknown" }`, or an object with `status: "used"` and nonempty `id`, `version`, `backend`, `grammar`, `grammar_version`, `contract_ref`. Unknown parser identity cannot satisfy processing verification: reject, do not silently call it not applicable. Do not mandate a parser for plain text. Normalized digest verification proves the retained normalized bytes; reproducing a transformation requires its pinned algorithm/configuration and is a later adapter conformance check, not established by a fingerprint alone.

Same original bytes with a new processing fingerprint are a new **projection**, not evidence of a source edit; they require a distinct revision reference when advanced. Same normalized bytes do not erase an observation. Neither touched chunks nor equal hashes establish embedding compatibility. Embedding generation and model/configuration rebuild policy remain in the owning subsystem; the handoff contract is below.

## Embedding contract handoff

The optional `embedding_contract` object records which embedding contract the producer's projection assumes. It is an exact object: `owner` (nonempty identity of the embedding-owning subsystem), `model_ref` (nonempty immutable reference to the model contract), `model_revision` (nonempty revision identifier, or null meaning explicitly unknown — never guessed or defaulted), `dimensions` (positive integer or null), `normalization` (nonempty string or null), `instruction_profile` (nonempty string or null). Malformed shapes reject with named reason `embedding`.

The handoff is **attribution, not attestation**: it never claims that any stored vector satisfies the contract, and it moves no embedding generation, storage or rebuild logic into this contract. Content reuse and vector compatibility are distinct decisions owned by `owner`: equal content digest plus equal embedding contract does not make vectors current, and the same content under a changed contract (different `model_revision`, `dimensions`, `normalization` or `instruction_profile`) may require regeneration. An importer early-return on unchanged content MUST NOT be read as attesting current-contract vectors — pending/failed/completed regeneration state lives with the owner. Absence of `embedding_contract` asserts nothing about vectors either way.

## Scan and deletion authority

`scan.status` is `complete`, `partial`, `interrupted` or `unknown`. `enumerated_scope` equals the full scope exactly. `checkpoint_ref` and `finalization_ref` are nonempty evidence refs or null. Complete requires finalization; non-complete MUST have null finalization. A checkpoint is progress only, never completion. Successful processing/job completion is not source enumeration completion.

`deletion.targets` is a duplicate-free array of scoped prior delta IDs (the enclosing scope and prior revision supply target identity). V1 has three modes:

1. **`none`:** `authority_ref` is null and targets empty. The observation can be verified even if the unchanged delta result contains removed IDs. No deletion is authorized by this observation; no implicit empty-input rule exists.
2. **`absence`:** complete, finalized, same-scope enumeration; validated current prior inventory; externally trusted authority evidence granting `absence` for that producer/scope and that exact finalization ref. Targets MUST equal the delta deleted IDs, each present in prior and absent from current. This includes ordinal supersession, not only disappearance of a whole source document. Complete authoritative empty may delete all prior chunks. A partial/interrupted/unknown empty result cannot do so.
3. **`explicit_source`:** independently verified source-deletion event granting `explicit_source` for this producer/scope and exactly the listed targets. A complete scan is not required. Prior validation and target membership still apply; current inventory must be empty, and targets equal both prior IDs and delta deleted IDs. Original/normalized evidence describes that prior. Permission loss, transient absence and supersession are not explicit source-deletion events. Missing/unknown authority rejects the request, never downgrades into inferred deletion.

Trusted context binds authority ref to producer ID, scope, mode, exact targets and finalization ref (null for explicit source deletion), and validates evidence externally. It also validates checkpoint/finalization refs when present. A payload cannot authorize itself by setting `complete` or providing a digest. Any verification failure produces **no authorized effects**; do not partially apply upserts before checking deletion/precondition proofs.

This contract defines authorization, not storage mechanics. Adapters keep their own apply order (hosted delete-first, Ur Brain upsert-first); this contract does not prescribe reordering. Overlapping current/upsert and deleted delta IDs reject. Adapters unable to enforce document scope or atomic validation must refuse application rather than strip scope down to a bare-ID delete. A consumer that does not verify observations has no observation guarantees — there is no compatibility fallback mode.

## Tombstone records and application atomicity

Applying an authorized deletion derives one **tombstone record** per target: `{scope, target delta ID, prior_revision_ref (where the target lived), cause (the deletion mode), authorizing observation_id and revision_ref, authority_ref}`. Tombstones are occurrence-scoped by the full scope plus prior revision — a bare delta ID is never a tombstone key, and a tombstone in one scope cannot suppress a chunk in another (cross-document collisions resolve by scope, not ID). The cause is exactly the deletion mode (`absence` or `explicit_source`) that authorized it; `none` authorizes no tombstones. Undeletion is not a tombstone edit: it is a fresh initial observation (null expected prior) on that scope after the storage owner clears the tombstone.

Application is all-or-nothing per observation. A failed application leaves no partial upserts or tombstones, and does not consume the observation: the next attempt is the exact-retry replay of the same payload (no re-authorization drift), while any different payload is ordinary conflicting reuse. The fixture model asserts this as no-effects-on-failure for every rejected case.

Version negotiation is exact-version: the envelope `schema` string is the companion version. A verifier supports specific versions and rejects any other (`schema`) — it never partial-parses a newer version or guesses at unknown fields, which reject (`fields`) rather than being silently dropped. There is no in-envelope feature negotiation; a producer targeting an older verifier emits the older schema. The delta result inside `legacy_result` is bound byte-for-byte; round-trip integrity is asserted by every fixture (the envelope bytes are never rewritten).

## Evidence retention and reference integrity

A verified decision carries a **retained-evidence manifest**: one entry per byte descriptor consumed (prior inventory, delta result, original, normalized, processing descriptor), each recording `domain`, `digest`, transport (`inline_base64` or `ref` with its reference name). The manifest is the reconstruction surface: an accepted observation stays re-verifiable exactly while those bytes (or resolvable references to them) remain available — no patch chains, no re-running producers. Reference lifetime is a retention obligation: evidence whose lifetime is shorter than the history referring to it makes that history non-re-verifiable, which must surface as rejection (`unavailable_bytes`) at the next verification, never as silent success.

When evidence expires, is redacted, becomes unauthorized or corrupt, the consumer **downgrades derivability explicitly**: the observation is marked no-longer-re-verifiable with the reason, and the last verified decision may be retained as an artifact — but the consumer MUST NOT assert that history can be rebuilt, and MUST NOT delete the downgrade record. Deleting or redacting evidence is itself recorded (which reference, what authority ordered it) so provenance of the gap survives the gap.

Reproducible versus irrecoverable: content digests, chunk indexes, inventories and projections are reproducible from retained inputs plus the pinned algorithms in the processing descriptor; embeddings are reproducible only under their owner's contract (see embedding contract handoff). **Authority grants, deletion decisions, role/intent assignments and trusted-head decisions are irrecoverable if omitted** — they are assertions about events, not functions of bytes, and are retained as first-class records (their durable ledger is plans #7). Access scope for retained evidence follows the scope that produced it; nothing here authorizes cross-scope reads.

## Delta result dialects

Dialect identifiers name the delta result shapes this contract validates. They are reference shapes for validation, not preserved systems; neither has ever been deployed.

`hosted-rag-v1` names the hosted adapter's delta result (`schema_ref: "RAG_INGESTION_ADAPTER_CONTRACT.md#initial-private"`): chunk IDs pair ordinal and content hash; manifest `updated` lists current IDs and `removed` prior IDs; `exports.chunks_jsonl`, `upserts_jsonl` and `deletes_jsonl` are JSONL **strings** (including empties and newline delimiters); upserts contain added/updated chunks only.

`ur-brain-delta-v1` names the sidecar delta result (`schema_ref: "ur_brain.structuredmerge_delta.v1"`): `pgvector_queue` and `deletes_jsonl` are **arrays** despite the latter's name; the queue is full-current including reused rows (do not filter it using hosted touched semantics); its source-ref-bearing ID scheme is independent of the hosted scheme. The dialects are separate identity algorithms; this contract does not unify them.

The standalone shared validator checks dialect shape, exact-byte digest, compact inventory/delta consistency and deletion proofs. It does not call producers to regenerate results or establish whole-adapter conformance. Unknown dialect fields are opaque — never projected away, never interpreted.

## Retry, revision and time semantics

Dedupe key is `(producer.id, full scope, observation_id)`. An accepted key binds the schema and payload digest. Exact retry returns the same verified decision with no second advancement/effect, even if the trusted head has since advanced. Conflicting reuse rejects before preconditions are reconsidered. Verify payload digest before consulting replay state; an attacker cannot change bytes while reusing the declared digest. Unknown schema rejects even on retry. The dedupe hash domain is the exact payload byte string — there is no canonicalization step, and a semantically equivalent reserialization is a different payload.

Re-referencing a retained revision is valid **only as a fresh observation of the same projection**: the re-observing envelope (different `observation_id`) must carry projection evidence identical to the retained revision's — same delta result bytes, original bytes, normalized bytes and processing fingerprint — and the head does not advance. Re-referencing a revision with different projection evidence rejects (named reason `revision`); recording repeated observations is thereby independent of content revisions, embedding reuse, and revision advancement, and a same-content no-op observation is recordable rather than discarded. On a re-observation the ancestry chain-edge requirement is vacuous when `expected_prior_revision_ref` equals the re-referenced `revision_ref` (a revision is not its own parent).

First deliveries compare `expected_prior_revision_ref` against externally trusted current head with atomic compare-and-set before any effects. Null means explicitly no prior, not unspecified. Failure rejects without effects; stale source timestamps never override this precondition. Late or out-of-order deliveries reject on the precondition; the only reconciliation is a fresh observation declaring the correct current prior — there is no force-accept or out-of-band healing mode. Atomic event visibility: no part of an observation (head advancement, replay entry, revision record) is committed unless every proof passes; verifiers never expose a partially applied observation.

Timestamps use RFC 3339 UTC `YYYY-MM-DDTHH:MM:SS[.fraction]Z`. `source_at` is source-asserted time, null if unknown (not processing time). `observed_at` is when the producer observed that source state; `processed_at` is when this projection was produced. They are attribution, not authorization, causal ordering, or trusted clock evidence; no sort-by-time revision advancement is implied. No implicit clock or timezone defaults. Source times are never silently substituted: unknown stays explicitly null/absent, and job, queue or processing clocks MUST NOT populate `source_at` or the `source_time_start`/`source_time_end` interval.

## Shared validation and remaining gates

Shared cases live in `diagnostics/slice-1045-ingest-observation-deletion-authority/contract.json`, `diagnostics/slice-1046-document-identity-occurrence-scoping/contract.json`, `diagnostics/slice-1047-revision-ancestry-merge-roles/contract.json` and `diagnostics/slice-1048-temporal-dedupe-preconditions/contract.json` and `diagnostics/slice-1049-embedding-contract-handoff/contract.json` and `diagnostics/slice-1050-tombstones-atomicity-compatibility/contract.json` and `diagnostics/slice-1051-evidence-retention-integrity/contract.json` in the fixtures repository, exercised by `python3 tools/validate_ingest_observations.py` and validator unit tests. These are designed contract examples, not captured runtime outputs. Invalid cases must fail for a named reason, not simply parse as JSON.

Coverage includes both dialects, repeated equal chunks, distinct document scopes, ordinal prepend/reorder without lineage, source whitespace/newline preservation, changed processing/same bytes, complete-empty authority, non-authoritative partial/interrupted/unknown/empty, explicit tombstones, mismatched scope/prior, missing/unavailable source or processing proof, idempotent/conflicting retries, late prior rejection, rename as fresh scope, namespace disjointness, and declared ancestry (linear chain, multi-parent merge, external/unknown parent retained, missing/self/duplicate/root-contradiction rejections, content-equal distinct revisions, source time intervals and no-substitution, unchanged-content no-advance re-observation, projection-evidence revision reuse rejection, and scope-bound dedupe, and embedding-contract handoff (same/changed contract over equal content, explicit unknown model revision, malformed rejection), and derived tombstone records (scope/cause/observation/authority binding) with overlapping-delete rejection), and retention manifests with expired-reference rejection)).

Remaining separate approval/work: adapter selection and real conformance, trusted evidence resolution/authentication, scoped storage migration and atomic ordering, immutable revision/replay persistence, embedding policy, reference retention/expiry and staged opt-in rollback. No issue is closed by this spec/fixture increment.
