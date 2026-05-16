# Slice 940: Ruby Prism Edit Projection Insert Child

## Status

Accepted for Ruby-first implementation.

## Context

Slices 938 and 939 prove Prism source-preserving `replace_node` and
`delete_node` edit projection for Ruby methods. The remaining basic operation
is inserting a child declaration into an existing class body.

## Contract

The Prism provider supports `insert_child` for a class node that exposes
`metadata.prism.node_path`. The provider:

- finds the target class node by Prism node path,
- inserts caller-provided replacement source before the class closing `end`,
- preserves replacement indentation as provided by the caller,
- reparses the result with Prism, and
- returns the shared tree-haver edit-projection execution result.

This slice covers insertion of a method declaration into an empty class.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-940-prism-edit-projection-insert-child/method-insert-child.json`.
