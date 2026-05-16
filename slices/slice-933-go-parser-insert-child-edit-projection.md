# Slice 933: go/parser Insert Child Edit Projection

## Status

Accepted for implementation.

## Context

Slice 932 records `go/parser` `insert_child` as a planned top-level
declaration operation. This slice implements that matrix entry against the same
shared edit-projection execution contract used by slices 928 through 931.

## Contract

`go/parser` supports `insert_child` for top-level Go declarations by using
`metadata.go_parser.node_path` correlation. For this slice,
`target_node_path: "decls[N]"` inserts the replacement declaration before the
declaration at index `N`; `N == len(decls)` appends to the declaration list.

Rendering is performed through Go's standard formatter. This preserves Go
syntax and canonical formatting, but does not retain arbitrary source
decorations.

The shared edit-projection execution result contract from slice 928 is reused
unchanged.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-933-go-parser-insert-child-edit-projection/insert-child-edit-projection.json`.
