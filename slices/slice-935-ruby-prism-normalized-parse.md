# Slice 935: Ruby Prism Normalized Parse

## Status

Accepted for Ruby-first implementation.

## Context

The Ruby implementation should become useful sooner than the other language
implementations. Prism already backs Ruby parsing and structured-edit projection
fixtures, but downstream tooling still needs Prism facts projected into the
shared tree-haver normalized tree shape instead of consuming raw Prism nodes.

## Contract

The Prism provider exposes a normalized parse result for Ruby source. The
provider may retain raw Prism nodes internally, but downstream consumers receive
tree-haver nodes with:

- stable provider-scoped node ids,
- byte and point spans,
- source fragments,
- portable semantic roles,
- Prism backend kinds, and
- opaque Prism metadata under the `prism` metadata namespace.

This slice covers the first concrete shape: a Ruby class containing one method.
The root, class, and method nodes are enough to prove provider metadata,
parent/child links, source spans, source fragments, and Ruby symbol metadata.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-935-prism-normalized-parse/class-method-normalized-tree.json`.
