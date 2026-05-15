# Slice 919: ast-crispr Selection Profile Helpers

## Status

Accepted for implementation.

## Context

Legacy ast-crispr separated structural edit selection concerns from match-span
concerns. The new package keeps that shape as a thin ergonomic layer over the
ast-merge structured-edit substrate.

## Contract

Each implementation exposes a selection profile helper that preserves the
profile's input vocabulary while projecting known values into stable families.

The portable report includes:

- `owner_scope`
- `owner_selector`
- `owner_selector_family`
- `known_owner_selector`
- `selector_kind`
- `selector_kind_family`
- `known_selector_kind`
- `selection_intent`
- `selection_intent_family`
- `known_selection_intent`
- `comment_region`
- `comment_region_family`
- `known_comment_region`
- `comment_anchored`
- `include_trailing_gap`

Unknown vocabulary is preserved verbatim and reported with family `unknown`.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-919-ast-crispr-selection-profile-helpers/ast-crispr-selection-profile-helpers.json`.
