# pgvector Plan Contract

`structuredmerge.pgvector_plan.v1` describes how a RAG ingest result can be
loaded into PostgreSQL with pgvector after an embedding provider creates vectors.

This contract is intentionally not an embedding contract. StructuredMerge owns
stable chunks, deltas, source artifacts, and SQL shape. The embedding service
owns model selection and vector generation.

## Shape

```json
{
  "schema": "structuredmerge.pgvector_plan.v1",
  "target": "pgvector_postgres",
  "table": "structuredmerge_chunks",
  "extension": "vector",
  "setup_sql": [],
  "delete_sql": "...",
  "upsert_sql": "...",
  "sources": {},
  "embedding_contract": {},
  "row_mapping": {},
  "metadata_fields": [],
  "metrics": {}
}
```

## SQL

`setup_sql` should include:

- `CREATE EXTENSION IF NOT EXISTS vector`
- table creation for chunk id, embedding, text, metadata, content hash, and
  update timestamp
- an optional vector index suitable for the chosen distance operator

`delete_sql` should delete removed chunk IDs before upserts.

`upsert_sql` should insert or update rows by stable chunk ID.

## Sources

Sources point back to the RAG pilot packet deliverables:

```json
{
  "upserts_jsonl": "deliverables.upserts_jsonl",
  "deletes_jsonl": "deliverables.deletes_jsonl"
}
```

## Embedding Boundary

The embedding contract should state:

```json
{
  "input_text_field": "text",
  "output_embedding_parameter": "$2",
  "embedding_required_for_upserts": true
}
```

Rows from `upserts_jsonl` need embeddings before they can be written to pgvector.
Rows from `deletes_jsonl` do not.

## Row Mapping

The initial row mapping is:

```json
{
  "id": "$1",
  "embedding": "$2",
  "text": "$3",
  "metadata": "$4",
  "content_hash": "$5"
}
```

The metadata object should include stable provenance fields such as `ordinal`,
`content_hash`, `start_byte`, and `end_byte`.
