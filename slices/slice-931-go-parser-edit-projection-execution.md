# Slice 931: go/parser Edit Projection Execution

## Status

Accepted for implementation.

## Context

Slices 928 through 930 prove `go-dst` edit projection across three top-level
declaration operations. The default continuation rule now broadens the same
operation shape to another concrete native provider before broad
generalization.

## Contract

`go/parser` supports `replace_node` for top-level Go declarations by using
`metadata.go_parser.node_path` correlation. For this slice,
`target_node_path: "decls[N]"` replaces the declaration at index `N`.

Unlike `go-dst`, `go/parser` does not retain source decorations. Rendering is
performed through Go's standard formatter, so this provider proves native edit
projection across a lower-format-preservation backend.

The shared edit-projection execution result contract from slice 928 is reused
unchanged.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-931-go-parser-edit-projection-execution/edit-projection-execution.json`.
