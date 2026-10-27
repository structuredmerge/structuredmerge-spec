# Plan: incorporation decisions — 2026-10-26

Slice 1054 under [plans #7](https://github.com/structuredmerge/plans/issues/7) — the last open issue in the plans tracker.

## Scope

Spec-only increment: the incorporation-decision record shape on the observation envelope. Specified against the v2 identity model per slice 1052; the issue's compatibility framing is superseded.

## Changes

1. `INGEST_OBSERVATION_CONTRACT.md`: `incorporation` field row, "Incorporation decisions" section, corpus list/coverage/preamble.
2. `slices/slice-1054-incorporation-decisions.md`.
3. Fixtures: `diagnostics/slice-1054-incorporation-decisions/contract.json` (5 positives, 5 negatives); validator `incorporation` rules with shared occurrence-ref parsing.

## Verification

Validator unit tests 12/12 across all nine corpora (1045–1053 unchanged); validator 99% lines (remainder is the `__main__` guard).

## Follow-ups

With #7 closed after merge, every issue in the tracker (#1–#12) is closed. The observation contract family is complete: envelope, identity, ancestry, temporal/dedupe, embedding handoff, tombstones/atomicity, retention, lineage, incorporation.
