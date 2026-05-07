# RAG Ingestion Adapter Contract

## Status

Initial private contract for the StructuredMerge RAG ingestion pilot.

This contract describes the boundary between StructuredMerge ingest output and a
downstream embedding/vector-store pipeline.

## Goals

The adapter contract MUST make it possible to:

1. upsert only chunks that need embeddings,
2. delete chunks that disappeared,
3. leave unchanged chunks alone,
4. preserve provenance for each chunk,
5. report ingestion stability metrics, and
6. replay or audit the ingest job later.

## Ingest Result Shape

An ingest result contains:

```json
{
  "outcome": "applied",
  "format": "text",
  "input_hash": "sha256:...",
  "chunks": [],
  "manifest": {},
  "metrics": {},
  "exports": {}
}
```

## Chunk Object

Each chunk object MUST include:

```json
{
  "id": "chunk:0:sha256:...",
  "ordinal": 0,
  "content_hash": "sha256:...",
  "start_byte": 0,
  "end_byte": 12,
  "text": "..."
}
```

Required fields:

- `id`: stable chunk identity for this ingest output.
- `ordinal`: chunk order within the normalized input stream.
- `content_hash`: hash of chunk text.
- `start_byte`: byte offset in the normalized ingest text.
- `end_byte`: exclusive byte offset in the normalized ingest text.
- `text`: chunk text to embed or store.

## Manifest

The manifest MUST include compact chunk references plus delta sets:

```json
{
  "chunks": [
    {
      "id": "chunk:0:sha256:...",
      "ordinal": 0,
      "content_hash": "sha256:..."
    }
  ],
  "added": [],
  "updated": [],
  "removed": [],
  "touched": []
}
```

Delta meanings:

- `added`: new chunk IDs that should be embedded and upserted.
- `updated`: current chunk IDs that replace previous chunks at the same ordinal.
- `removed`: previous chunk IDs that should be deleted from downstream storage.
- `touched`: current chunk IDs whose content hash matched the prior manifest and
  do not need re-embedding.

`updated` and `removed` are paired by ordinal in the current initial algorithm:
the current chunk ID appears in `updated`, while the prior chunk ID appears in
`removed`.

## Exports

The exports object MUST include three JSONL strings:

```json
{
  "chunks_jsonl": "...",
  "upserts_jsonl": "...",
  "deletes_jsonl": "..."
}
```

### `chunks_jsonl`

All current chunks, one chunk object per line.

Use this for full rebuilds, inspection, and simple loader integrations.

### `upserts_jsonl`

Only chunks whose IDs appear in `manifest.added` or `manifest.updated`, one chunk
object per line.

Use this for embedding work and vector-store upserts.

### `deletes_jsonl`

Only removed previous chunk IDs, one deletion object per line:

```json
{"id":"chunk:0:sha256:..."}
```

Use this for vector-store deletes.

## Metrics

The metrics object MUST include:

```json
{
  "chunk_count": 3,
  "jsonl_line_count": 3,
  "added_count": 1,
  "updated_count": 1,
  "removed_count": 1,
  "touched_count": 1,
  "unchanged_chunk_percentage": 33.33,
  "embedding_invalidation_count": 3
}
```

Metric meanings:

- `chunk_count`: number of current chunks.
- `jsonl_line_count`: number of lines in `chunks_jsonl`.
- `added_count`: count of `manifest.added`.
- `updated_count`: count of `manifest.updated`.
- `removed_count`: count of `manifest.removed`.
- `touched_count`: count of `manifest.touched`.
- `unchanged_chunk_percentage`: touched current chunks divided by current chunks.
- `embedding_invalidation_count`: added + updated + removed.

## Prior Manifest Input

The next ingest run MAY receive a prior ingest result, manifest, or full job
response as `previous_manifest`.

Supported shapes:

- prior result: `{ "manifest": { ... } }`
- prior manifest: `{ "chunks": [...], "added": [...], ... }`
- prior job response: `{ "result": { "manifest": { ... } } }`

## Vector-Store Adapter Behavior

A vector-store adapter SHOULD:

1. read `deletes_jsonl` and delete those IDs first,
2. read `upserts_jsonl`,
3. embed each upsert chunk's `text`,
4. store each vector under the chunk `id`,
5. store chunk metadata including `ordinal`, `content_hash`, and source span,
6. skip all `touched` chunks.

The adapter SHOULD NOT re-embed chunks listed only in `touched`.

## Initial Adapter Targets

The generic JSONL target is the default adapter target. It uses
`upserts_jsonl`, `deletes_jsonl`, chunk `id`, chunk `text`, and metadata fields
already present in chunk rows.

The first concrete database target is pgvector/PostgreSQL. Producers SHOULD
describe pgvector table and column names in the pilot packet, but they are not
required to connect to PostgreSQL or write embeddings directly.

## Audit Expectations

The hosted control plane SHOULD retain:

- the ingest job,
- the result artifact,
- the ingest report,
- artifact metadata,
- artifact verification status,
- event history,
- and replay evidence.

This allows a pilot report to explain exactly what changed between ingestion
runs.
