# Slice 848: Tree Haver Old Backend Implementation Inventory

## Goal

Classify the old Ruby `tree_haver` backend implementation files and aliases
against the active StructuredMerge backend substrate.

## Contract

Surviving active backend families:

- `tree-sitter-language-pack` is the active generic tree-sitter backend surface;
- PEG backends survive as explicit Citrus and Parslet adapter primitives;
- Kaitai survives as the binary/schema tree substrate;
- native/source providers survive through capability reports, normalized tree
  projection, metadata, diagnostics, and provider-local parsers.

Retired shared backend paths:

- old MRI, Rust, FFI, and Java tree-sitter backends are not copied into the
  active shared Ruby substrate;
- old Prism and Psych tree-haver backends are replaced by provider-local Ruby
  and YAML implementations that project normalized trees and provider
  capability reports;
- old compatibility aliases such as `TreeSitter::*` shims are retired;
- old grammar finder and path validator implementation details are deferred to
  the grammar/library path security slice.

Rule:

- a backend implementation is active only if it has a backend reference,
  capability/profile fixture, provider diagnostics, and at least one conformance
  path using it.
