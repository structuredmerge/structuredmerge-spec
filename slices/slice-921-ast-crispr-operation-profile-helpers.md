# Slice 921: ast-crispr Operation Profile Helpers

## Status

Accepted for implementation.

## Context

Legacy ast-crispr used operation profiles to describe whether an edit selects
source content, needs a destination, and where replacement text comes from. The
revived ast-crispr package keeps that ergonomic vocabulary as a thin layer over
ast-merge structured-edit contracts.

## Contract

Each implementation exposes an operation profile helper that preserves input
vocabulary and classifies known operation kinds into stable families.

The portable report includes:

- `operation_kind`
- `operation_family`
- `known_operation_kind`
- `source_requirement`
- `known_source_requirement`
- `destination_requirement`
- `known_destination_requirement`
- `replacement_source`
- `known_replacement_source`
- `captures_source_text`
- `supports_if_missing`
- `selects_source`
- `requires_source`
- `supports_destination`
- `requires_destination`
- `explicit_replacement`
- `may_reuse_captured_text`

Unknown vocabulary is preserved verbatim and reported with family `unknown`
where a family applies.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-921-ast-crispr-operation-profile-helpers/ast-crispr-operation-profile-helpers.json`.
