# Slice 726: Kaitai schema-backed parse result

## Goal

Turn the Kaitai substrate from a static contract shape into a parser-result
surface that `tree_haver` can expose consistently across Ruby, Go, Rust, and
TypeScript.

## Contract

A Kaitai-backed parse result carries:

1. the backend reference `{ id: "kaitai-struct", family: "kaitai" }`;
2. the schema identifier, normally the `.ksy` basename or package identifier;
3. the raw source byte length;
4. a normalized root `KaitaiTreeNode`;
5. schema-path keyed diagnostics for parse, bounds, checksum, and unsupported
   runtime failures.

Each `KaitaiTreeNode` carries:

- `kind`;
- `schema_path`;
- `span` as a half-open byte range;
- decoded `fields`;
- child nodes in source order when order is meaningful.

## Runtime Boundary

Implementations may use native Kaitai runtimes, generated parsers, or fixture
adapters. The portable contract is the normalized result shape, not a mandate
that every language use the same Kaitai runtime package.

## Safety

Malformed binary input must return diagnostics rather than partial writable
state unless a family-specific parser marks a subtree as safely recoverable.
