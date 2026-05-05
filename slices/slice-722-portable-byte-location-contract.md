# Slice 722: Portable byte location contract

Structured source, document, config, and binary families need the same location
vocabulary when they report owners, diagnostics, nested matches, or preserved
byte ranges. A portable byte-location contract defines half-open byte ranges,
source points, and source spans independently from any one parser backend.

The contract adds:

1. a half-open byte range shape, `[start_byte, end_byte)`;
2. source points with zero-based `row` and byte-oriented `column`;
3. source spans combining a byte range with start and end points;
4. helper semantics for byte length, containment, overlap, byte slicing, and
   line/column-to-byte-offset projection.

The location contract is useful for existing AST-backed families and for future
Kaitai-backed binary families. Binary formats may omit source points when row
and column positions are not meaningful, but byte ranges remain required for
preservation, diagnostics, and renderer planning.
