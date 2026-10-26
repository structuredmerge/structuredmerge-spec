# Plan: document identity, namespace and occurrence scoping — 2026-10-26

Slice 1046 under [plans #4](https://github.com/structuredmerge/plans/issues/4).

## Scope

Spec-only increment extending the ingest-observation contract with document identity, namespace and rename/alias semantics, plus shared validator fixtures. No workflow edit required; no runtime adapter changes.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: new "Document identity, namespace and rename/alias semantics" section; shared-validation section now lists both fixture corpora.
2. `slices/slice-1046-document-identity-occurrence-scoping.md`: this slice.
3. Fixtures repository: `diagnostics/slice-1046-document-identity-occurrence-scoping/contract.json` (6 cases) and harness support for multiple corpora.

## Verification

All six cases pass through the unmodified shared validator (`tools/validate_ingest_observations.py`), which already enforced full-scope matching, prior-inventory scope equality, and inventory ID/ordinal uniqueness — the fixtures demonstrate the boundary rather than add validator rules. Validator unit tests: 12/12 across both corpora.

## Follow-ups

- plans #8 (temporal/dedupe/preconditions) now unblocked except for #5 dependency decisions.
- Alias-ledger design (trusted external alias evidence) deferred with #5/#7.
