# Slice 924: tree_haver Edit Projection Support

## Status

Accepted for implementation.

## Context

Native parser providers may retain mutable native trees internally while
downstream structuredmerge users consume one normalized tree shape. Edit
projection support describes whether normalized node selections can be projected
back into the provider's native edit surface.

## Contract

Each implementation exposes an edit projection support report with:

- `backend_ref`
- `language`
- `supports_edit_projection`
- `native_edit_target`
- `normalized_edit_target`
- `supported_operations`
- `required_node_fields`
- `correlation_keys`
- `preserves_source_fragments`
- `unsupported_reason`
- `diagnostics`

Unsupported providers MUST report `supports_edit_projection: false`, an
`unsupported_reason`, empty supported operations, and diagnostics rather than
raising solely because edit projection is unavailable.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-924-tree-haver-edit-projection-support/edit-projection-support.json`.
