# Slice 932: Edit Projection Provider Operation Matrix

## Status

Accepted for implementation.

## Context

Slices 928 through 931 prove edit-projection execution against concrete Go
native providers:

- `go-dst` executes `replace_node`, `insert_child`, and `delete_node`.
- `go/parser` executes `replace_node`.

The next shared contract should make these provider differences explicit
without forcing downstream callers to inspect provider-specific tests or slice
history.

## Contract

Tree-haver exposes an edit-projection provider operation matrix. The matrix
records:

- the operation vocabulary being compared,
- each provider and backend reference,
- per-provider source-preservation expectations,
- each operation's support status,
- the node scope currently covered,
- correlation keys required for execution,
- fixture slices that prove implemented behavior, and
- diagnostics for known gaps.

Operation status values are:

- `implemented`: fixture-backed execution exists for the provider.
- `planned`: the provider is expected to support the operation later, but no
  execution fixture exists yet.
- `unsupported`: the provider does not intend to support the operation.

The matrix is descriptive. It does not select a default provider, enforce a
profile promotion gate, or imply silent fallback behavior.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-932-edit-projection-provider-operation-matrix/provider-operation-matrix.json`.
