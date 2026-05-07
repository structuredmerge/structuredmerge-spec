# RAG Pilot Packet Contract

`structuredmerge.rag_pilot_packet.v1` is the customer-facing packet for a RAG
ingestion pilot. It packages the stable-ingestion result, vector-store JSONL
deliverables, artifact verification, and adapter handoff instructions into one
auditable object.

## Shape

```json
{
  "schema": "structuredmerge.rag_pilot_packet.v1",
  "job": {},
  "summary": {},
  "metrics": {},
  "manifest": {},
  "deliverables": {},
  "adapter_handoff": {},
  "artifact_verification": {}
}
```

Fields:

- `schema`: literal contract identifier.
- `job`: compact job identity, status, account, operation, hashes, and
  timestamps.
- `summary`: small pilot-facing metrics for executive and operator review.
- `metrics`: full ingest metrics from the RAG ingestion adapter contract.
- `manifest`: chunk delta manifest from the ingest result.
- `deliverables`: JSONL streams and report metadata available to the customer.
- `adapter_handoff`: field and source names a vector-store adapter should use.
- `artifact_verification`: hash/size verification for stored artifacts.

## Summary

The summary should include:

- `chunk_count`
- `unchanged_chunk_percentage`
- `embedding_invalidation_count`
- `requires_reembedding`

`requires_reembedding` is true when the invalidation count is greater than zero.

## Deliverables

The initial deliverables are:

- `chunks_jsonl`: every stable chunk,
- `upserts_jsonl`: chunks that should be embedded or re-embedded,
- `deletes_jsonl`: stale chunk IDs that should be removed,
- `ingest_report`: report metadata.
- `rag_pilot_packet`: artifact metadata for the packet itself, when materialized.
- `rag_pilot_summary`: customer-readable Markdown summary artifact, when
  materialized.
- `pgvector_plan`: pgvector SQL/load-plan metadata, when materialized.
- `pgvector_queue`: pgvector-specific embedding queue JSONL, when materialized.

Each JSONL deliverable should include:

```json
{
  "kind": "upserts_jsonl",
  "artifact_id": "uuid",
  "content_hash": "sha256:...",
  "line_count": 2,
  "byte_size": 200,
  "available": true
}
```

Empty streams may have `available: false` when no artifact was materialized, but
they should still report `line_count` and `byte_size`.

The `rag_pilot_packet` and `rag_pilot_summary` deliverables should include their
`artifact_id`, `content_hash`, `byte_size`, and `available` flag so customers can
verify the packet and summary artifacts they received.

## Adapter Handoff

The first adapter handoff shape is:

```json
{
  "default_target": "generic_jsonl",
  "upsert_source": "deliverables.upserts_jsonl",
  "delete_source": "deliverables.deletes_jsonl",
  "stable_id_field": "id",
  "text_field": "text",
  "skip_touched_chunks": true,
  "targets": {}
}
```

Adapters should embed rows from `upserts_jsonl`, delete IDs from
`deletes_jsonl`, and avoid re-embedding chunks that are only listed as touched.

### `generic_jsonl`

The default target is `generic_jsonl`. It describes source paths and row fields
without assuming a vendor-specific vector database.

```json
{
  "upsert_source": "deliverables.upserts_jsonl",
  "delete_source": "deliverables.deletes_jsonl",
  "delete_id_field": "id",
  "upsert_id_field": "id",
  "text_field": "text",
  "metadata_fields": ["ordinal", "content_hash", "start_byte", "end_byte"]
}
```

### `pgvector_postgres`

The first concrete database target is `pgvector_postgres`. This is a handoff
shape, not a requirement that the producer connect to PostgreSQL. The detailed
load-plan shape is `structuredmerge.pgvector_plan.v1`.

```json
{
  "extension": "vector",
  "table": "structuredmerge_chunks",
  "id_column": "id",
  "embedding_column": "embedding",
  "text_column": "text",
  "metadata_column": "metadata",
  "delete_statement": "DELETE FROM structuredmerge_chunks WHERE id = ANY($1)",
  "upsert_statement": "INSERT INTO structuredmerge_chunks (id, embedding, text, metadata) VALUES ($1, $2, $3, $4) ON CONFLICT (id) DO UPDATE SET embedding = EXCLUDED.embedding, text = EXCLUDED.text, metadata = EXCLUDED.metadata"
}
```

## Relationship To Ingest Report

The ingest report is a technical report for one ingest job. The RAG pilot packet
is the customer/pilot handoff wrapper around that report plus artifact metadata
and adapter instructions.
