# Slice 938: Ruby Prism Edit Projection Replace Node

## Status

Accepted for Ruby-first implementation.

## Context

The Ruby Prism provider now exposes normalized node ids, spans, source
fragments, and Prism node paths. The next useful Ruby tooling step is to use
that normalized tree metadata to perform a source-preserving edit projection.

## Contract

The Prism provider supports `replace_node` for normalized Ruby nodes that expose
`metadata.prism.node_path`. The provider:

- finds the target normalized node by Prism node path,
- replaces the node's original byte range with explicit replacement source,
- reparses the result with Prism, and
- returns the shared tree-haver edit-projection execution result.

This slice covers replacement of a method declaration inside a class. The edit
is source-spliced, not pretty-printed, so surrounding formatting is preserved.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-938-prism-edit-projection-replace-node/method-replace-node.json`.
