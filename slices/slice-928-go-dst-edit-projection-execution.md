# Slice 928: go-dst Edit Projection Execution

## Status

Accepted for implementation.

## Context

Slice 924 records whether a provider supports projecting normalized edits into
its retained native tree. This slice proves the first concrete execution path:
`go-dst` applies a normalized `replace_node` edit to its provider-internal
dave/dst tree and renders the updated Go source.

## Contract

The shared tree_haver contract exposes edit-projection execution requests and
results. A request names the provider, backend reference, language, source, and
one or more operations. A result includes:

- `ok`,
- `status`: `applied` or `rejected`,
- rendered source,
- applied operation summaries, and
- structured provider diagnostics.

The first concrete operation is `replace_node` for `go-dst` using
`metadata.go_dst.node_path` correlation. Unsupported providers reject with a
blocking provider diagnostic instead of silently falling back.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-928-go-dst-edit-projection-execution/edit-projection-execution.json`.
