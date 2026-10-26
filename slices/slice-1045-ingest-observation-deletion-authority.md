# Slice 1045: Ingest observation and deletion authority

## Status

Spec-first, opt-in companion proposal for structuredmerge/plans#12, prioritizing
#2 and #3. Shared designed examples and a local verification model are provided;
no producer, adapter, authenticated resolver or deployed runtime conformance is
claimed. The Ruby golden-master rule remains unchanged: these new examples are
proposed admission expectations, not promoted captures of existing Ruby behavior.

## Contract

[INGEST_OBSERVATION_CONTRACT.md](../INGEST_OBSERVATION_CONTRACT.md) defines the
versioned envelope, exact-byte evidence, document-chunk scope, processing proof,
trusted prior precondition, retry binding, and deletion authorization.

The envelope is separate from the legacy result. Existing identifiers, ordinal
update/removal semantics, hosted JSONL strings and Ur Brain array exports remain
unchanged. A verified companion does not make an ID-only legacy importer safe.

## Safety invariants

- Partial, interrupted, unknown or merely empty observations confer no
  absence-derived deletion authority.
- Authoritative absence requires complete finalized enumeration of the exact
  document scope, a trusted current prior and separately trusted authority.
- Explicit source tombstones require their own scoped source-event authority;
  permission loss is not source deletion.
- Original and normalized bytes remain distinct and recoverable, with verified
  lengths/digests and a versioned processing descriptor.
- Verification fails before any modeled effects; retry keys bind payload bytes.
- Content equality does not establish lineage, source intent or vector reuse.

## Shared fixtures and executable gate

In the fixtures repository:

- `diagnostics/slice-1045-ingest-observation-deletion-authority/contract.json`
- `tools/validate_ingest_observations.py`
- `tools/test_validate_ingest_observations.py`

Run `python3 tools/validate_ingest_observations.py` and
`python3 -m unittest discover -s tools -p 'test_*.py'` from that repository.
The model resolves only supplied local evidence. It is not a network resolver,
cryptographic identity verifier, durable event store or runtime adapter.

## Remaining gates

Adapter selection, real producer conformance, scope-safe storage predicates,
atomic writes/revision preconditions, durable replay and revision persistence,
source authorization, evidence retention and rollout/rollback remain separate
work. Do not close plans #2, #3 or #12 on the basis of this increment alone.
