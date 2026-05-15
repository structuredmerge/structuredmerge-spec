# Slice 929: go-dst Insert-Child Edit Projection

## Status

Accepted for implementation.

## Context

Slice 928 proves `go-dst` can execute a normalized `replace_node` operation
against a retained provider-internal dave/dst tree. The default continuation
rule deepens that concrete provider before broadening to another provider.

## Contract

`go-dst` supports `insert_child` for top-level Go declarations by using
`metadata.go_dst.node_path` as an insertion slot. For this slice,
`target_node_path: "decls[N]"` means insert the replacement declaration before
the declaration currently at index `N`, or append when `N` equals the current
declaration count.

The shared edit-projection execution result contract from slice 928 is reused
unchanged.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-929-go-dst-insert-child-edit-projection/insert-child-edit-projection.json`.
