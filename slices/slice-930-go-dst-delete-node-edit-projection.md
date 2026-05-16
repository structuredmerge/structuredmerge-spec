# Slice 930: go-dst Delete-Node Edit Projection

## Status

Accepted for implementation.

## Context

Slices 928 and 929 prove `go-dst` edit projection for `replace_node` and
`insert_child` against top-level Go declarations. The default continuation rule
deepens the same provider with deletion before broadening to another provider.

## Contract

`go-dst` supports `delete_node` for top-level Go declarations by using
`metadata.go_dst.node_path` correlation. For this slice,
`target_node_path: "decls[N]"` removes the declaration at index `N`.

The shared edit-projection execution result contract from slice 928 is reused
unchanged.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-930-go-dst-delete-node-edit-projection/delete-node-edit-projection.json`.
