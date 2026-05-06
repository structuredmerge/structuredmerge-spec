# Slice 730: ZIP parser inventory

## Goal

Define the first ZIP parser behavior: read an archive and produce a stable
inventory report without rewriting bytes.

## Contract

The ZIP parser inventory reports:

1. archive format and schema identifier;
2. entry count and central-directory byte range;
3. every entry keyed by normalized path;
4. directory status;
5. compression method;
6. CRC32, compressed size, and uncompressed size;
7. byte ranges for local header, member data, and central-directory record;
8. diagnostics for unsupported or unsafe archive features.

## Parser Strategy

Implementations may parse ZIP directly, use standard library ZIP readers where
they expose enough offset metadata, or use Kaitai-backed output. If a standard
library reader hides required offsets, the implementation must add a thin
offset scanner rather than dropping byte-range fields.

## Output Boundary

This slice produces an inventory and diagnostics only. It does not plan a merge
or render a new archive.
