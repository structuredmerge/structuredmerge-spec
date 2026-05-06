# Slice 725: Tree-haver byte-span prior-art alignment

## Goal

Align the active `tree_haver` byte-location and tree-node contracts with the
useful byte-level behavior already proven in `reference/tree_haver`.

## Prior Art

The historical `reference/tree_haver` implementation already normalizes:

1. node byte offsets through `start_byte` and `end_byte`;
2. source points through row/column objects that also support hash-like access;
3. text extraction from node byte spans when the backend does not expose text;
4. incremental edit payloads with `start_byte`, `old_end_byte`, `new_end_byte`,
   `start_point`, `old_end_point`, and `new_end_point`;
5. wrapper boundaries where parser code owns backend wrapping and family code
   consumes normalized nodes.

## Contract

Active implementations should port those semantics into the portable contracts
instead of creating a separate binary-only model.

The shared byte contract should expose:

- half-open byte ranges for preserved and rewritten content;
- optional source points for text-like sources;
- byte-slice helpers that work on raw bytes and fail closed on invalid ranges;
- edit-span vocabulary that can describe both tree-sitter incremental edits and
  binary renderer rewrites.

## Boundary

This slice is not a ZIP parser and not a Kaitai runtime binding. It is a
planning and parity slice that prevents the binary path from diverging from the
existing `tree_haver` location model.
