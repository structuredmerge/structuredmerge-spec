# Slice 926: tree_haver Backend Availability

## Status

Accepted for implementation.

## Context

Old tree_haver used backend `available?` checks, RSpec backend tags, and
runtime-specific fallback ordering to avoid selecting parser backends whose
dependencies were not loadable. Active tree_haver needs the same information as
portable product data, not only test-suite control flow.

## Contract

Each implementation exposes a backend availability report with:

- the backend reference being evaluated,
- a stable status: `available`, `unavailable`, or `unknown`,
- named availability checks,
- per-check diagnostics, and
- report-level diagnostics.

Required checks determine availability. If any required check is unavailable,
the report is unavailable. If no checks are supplied, availability is unknown.
Optional checks may add diagnostics without blocking the backend.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-926-tree-haver-backend-availability/backend-availability.json`.
