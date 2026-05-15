# Slice 923: ast-crispr Batch Operation Helpers

## Status

Accepted for implementation.

## Context

Named ast-crispr operation helpers are useful individually, but recipe and
template tooling commonly plans ordered groups of edits. The batch helper gives
those tools a stable, implementation-neutral summary of an ordered operation
profile list without claiming provider execution behavior.

## Contract

Each implementation exposes a batch operation helper that accepts operation
profiles and returns:

- `operation_count`
- `operation_kinds`
- `operation_profiles`

Order MUST be preserved.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-923-ast-crispr-batch-operation-helpers/ast-crispr-batch-operation-helpers.json`.
