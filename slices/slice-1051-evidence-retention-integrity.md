# Slice 1051 — Evidence retention and reference integrity

- **Status:** Proposed
- **Parent contract:** `INGEST_OBSERVATION_CONTRACT.md` (new section "Evidence retention and reference integrity")
- **Tracking:** [plans #11](https://github.com/structuredmerge/plans/issues/11) (P1)
- **Depends on:** #3, #5 (closed); #7 referenced for the durable ledger only (reference/coverage decision per the issue's dependency note)

## Problem

The contract rejected unavailable/expired/mismatched evidence but deferred retention policy entirely ("future retention policy remains plans #11"): no reconstruction surface, no downgrade semantics for expired/redacted/corrupt evidence, and no statement of what is reproducible versus irrecoverable.

## Contract changes

1. **Retained-evidence manifest**: every verified decision carries one entry per consumed byte descriptor (prior inventory, legacy result, original, normalized, processing) with domain, digest, transport (`inline_base64` or `ref` + name). The manifest is the reconstruction surface — re-verifiability holds exactly while those bytes or references resolve; no patch chains, no re-running producers.
2. **Lifetime and downgrade**: evidence outliving its referrers is a retention obligation; expiry surfaces as `unavailable_bytes` at next verification, never silent success. Expired/redacted/unauthorized/corrupt evidence downgrades derivability explicitly — the downgrade record is never deleted, and consumers must not assert history is rebuildable. Deletion/redaction of evidence is itself recorded.
3. **Reproducible vs irrecoverable**: digests, indexes, inventories and projections are reproducible from retained inputs + pinned algorithms; embeddings only under the owner's contract. Authority grants, deletion decisions, role/intent assignments and trusted-head decisions are irrecoverable if omitted — retained as first-class records (durable ledger: plans #7). Access scope follows producing scope.

## Shared examples

`diagnostics/slice-1051-evidence-retention-integrity/contract.json` — a manifest-assertion case, and a two-step lifetime sequence (ref-resolved original verifies with a `via: ref` manifest entry; the same reference expiring between observations rejects `unavailable_bytes`). Dangling refs were already covered by 1045's `unavailable-original-bytes`.

## Non-goals

No storage implementation, GC, remote fetch, or the #7 ledger itself. Runtime adoption requires separate approval.
