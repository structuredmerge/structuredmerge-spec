# Slice 934: go/parser Delete Node Edit Projection

## Status

Accepted for implementation.

## Context

Slice 932 records `go/parser` `delete_node` as a planned top-level declaration
operation. With `replace_node` and `insert_child` already implemented, this
slice completes the initial `go/parser` top-level declaration edit-projection
operation set.

## Contract

`go/parser` supports `delete_node` for top-level Go declarations by using
`metadata.go_parser.node_path` correlation. For this slice,
`target_node_path: "decls[N]"` deletes the declaration at index `N`.

Rendering is performed through Go's standard formatter. This preserves Go
syntax and canonical formatting, but does not retain arbitrary source
decorations.

The shared edit-projection execution result contract from slice 928 is reused
unchanged.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-934-go-parser-delete-node-edit-projection/delete-node-edit-projection.json`.
