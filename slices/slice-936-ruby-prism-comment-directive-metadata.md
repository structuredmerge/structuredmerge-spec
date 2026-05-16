# Slice 936: Ruby Prism Comment Directive Metadata

## Status

Accepted for Ruby-first implementation.

## Context

Slice 935 proves Prism can project real AST nodes into the tree-haver
normalized tree. Ruby tooling also needs comment and directive information for
source-preserving edits, freeze regions, coverage boundaries, and package
template policy.

## Contract

The Prism normalized parse result includes Ruby comments as normalized
tree-haver comment nodes. Comment nodes expose:

- source spans and source fragments,
- parent links to either the program or containing declaration,
- portable semantic roles for comments and directives,
- magic comment metadata,
- `smorg:freeze` directive metadata, and
- `:nocov:` coverage directive metadata.

Raw Prism comment objects remain provider-internal. Downstream consumers use the
normalized node fields plus namespaced `metadata.prism` values.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-936-prism-comment-directive-metadata/comment-directives-normalized-tree.json`.
