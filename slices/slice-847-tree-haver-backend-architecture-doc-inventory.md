# Slice 847: Tree Haver Backend Architecture Doc Inventory

## Goal

Classify the old `tree_haver` backend architecture, position API, and
wrapping/unwrapping documentation against the active StructuredMerge Ruby
`tree_haver` substrate.

## Contract

Portable behavior:

- normalized tree nodes expose stable kind/type, children, source spans,
  source fragments where available, metadata, diagnostics, and backend
  capability references;
- positions use 1-based lines and explicit columns/byte ranges where the
  provider can supply them;
- backend capability reports describe parser identity, language/version,
  parse-error behavior, source span support, source fragment support, render
  strategies, semantic roles, normalized tree support, native node access, and
  diagnostics;
- backend selection is explicit through registry/context/profile fields and
  observable in suite planning and reports;
- temporary backend context is scoped and restored after the operation.

Retired or downgraded behavior:

- the old promise that Ruby `tree_haver` itself abstracts every parser backend
  used by every implementation is no longer portable architecture;
- Ruby-engine-specific tree-sitter adapters such as MRI, FFI, Rust, and Java are
  implementation candidates, not active portable claims;
- raw object wrapping/unwrapping rules remain a useful provider design pattern,
  but the portable contract is the normalized tree output, capability report,
  diagnostics, and edit projection behavior;
- thread-local backend switching is replaced by explicit scoped backend context
  and reportable plan context.

Provider rule:

- providers may retain native parser objects internally while projecting all
  downstream value into normalized node fields, node metadata, capabilities,
  diagnostics, or semantic sidecars;
- downstream structuredmerge users consume one normalized tree shape.
