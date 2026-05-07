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
  "indexing": {},
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

Vector index creation is deferred until the embedding provider has chosen a
fixed vector dimension. PostgreSQL can store variable-width `vector` values, but
pgvector HNSW indexes need an indexed dimension. The initial plan therefore
keeps writable table setup in `setup_sql` and exposes an index template in
`indexing`:

```json
{
  "status": "deferred_until_embedding_dimensions_known",
  "template": "CREATE INDEX IF NOT EXISTS structuredmerge_chunks_embedding_idx ON structuredmerge_chunks USING hnsw ((embedding::vector({dimensions})) vector_cosine_ops)"
}
```

`delete_sql` should delete removed chunk IDs before upserts.

`upsert_sql` should insert or update rows by stable chunk ID.

## Sources

Sources point back to the RAG pilot packet deliverables:

```json
{
  "upserts_jsonl": "deliverables.upserts_jsonl",
  "deletes_jsonl": "deliverables.deletes_jsonl",
  "pgvector_queue": "deliverables.pgvector_queue"
}
```

## Queue Rows

`pgvector_queue` is JSONL. Each row is ready for an embedding service to consume:

```json
{
  "id": "chunk:0:sha256:...",
  "text": "chunk text",
  "content_hash": "sha256:...",
  "metadata": {
    "ordinal": 0,
    "content_hash": "sha256:...",
    "start_byte": 0,
    "end_byte": 12
  }
}
```

After embedding, the service should bind:

- `$1`: `id`
- `$2`: generated embedding vector
- `$3`: `text`
- `$4`: `metadata`
- `$5`: `content_hash`

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
