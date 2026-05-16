# Slice 939: Ruby Prism Edit Projection Delete Node

## Status

Accepted for Ruby-first implementation.

## Context

Slice 938 proves Prism can replace a normalized Ruby node by source-splicing the
node byte range and reparsing. The next operation in the same provider lane is
line-aware deletion.

## Contract

The Prism provider supports `delete_node` for normalized Ruby nodes that expose
`metadata.prism.node_path`. The provider:

- finds the target normalized node by Prism node path,
- expands deletion to the containing source line to avoid indentation-only
  blanks,
- reparses the result with Prism, and
- returns the shared tree-haver edit-projection execution result.

This slice covers deletion of a method declaration inside a class.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-939-prism-edit-projection-delete-node/method-delete-node.json`.
