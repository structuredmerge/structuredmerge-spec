# Slice 920: ast-crispr Destination Profile Helpers

## Status

Accepted for implementation.

## Context

Legacy ast-crispr used destination profiles to describe how an insertion or
relocation destination was resolved. The revived ast-crispr package keeps this
as an ergonomic helper layered over ast-merge structured-edit contracts.

## Contract

Each implementation exposes a destination profile helper that preserves the
profile vocabulary while classifying known values into stable families.

The portable report includes:

- `resolution_kind`
- `resolution_family`
- `known_resolution_kind`
- `resolution_source`
- `resolution_source_family`
- `known_resolution_source`
- `anchor_boundary`
- `anchor_boundary_family`
- `known_anchor_boundary`
- `used_if_missing`
- `append_fallback`
- `anchored`

Unknown vocabulary is preserved verbatim and reported with family `unknown`.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-920-ast-crispr-destination-profile-helpers/ast-crispr-destination-profile-helpers.json`.
