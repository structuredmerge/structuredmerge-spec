# Slice 734: Kaitai serialization and ZIP provider strategy

## Goal

Clarify how Kaitai serialization relates to binary rendering and define the
first concrete ZIP render-provider strategy.

## Kaitai Boundary

Kaitai Struct can generate read-write code for some targets, but the shared
merge stack must not depend on Kaitai as a universal renderer.

Kaitai-backed serialization is treated as an optional provider capability:

1. a provider may expose Kaitai-generated `_check` and `_write` behavior when
   the target language and schema support it;
2. unsupported languages or schemas must report render-provider diagnostics
   instead of pretending writable support exists;
3. schema-backed serialization output must still be re-inventoried before final
   application;
4. format-family renderers remain responsible for checksums, dependent lengths,
   signatures, nested outputs, and safety policy that are outside the Kaitai
   object graph.

## First ZIP Provider

The first ZIP implementation should use the host ecosystem ZIP library as a
canonical rewrite provider:

- Ruby: `rubyzip`;
- Go: `archive/zip`;
- Rust: `zip`;
- TypeScript: a ZIP writer package selected by the TypeScript implementation.

This provider may rewrite the full archive instead of preserving compressed
member bytes. When it does, its report must say so explicitly:

- preserved compressed ranges: empty unless the provider can prove raw copying;
- rewritten nodes: all emitted entries and central-directory records;
- checksum updates: every changed or re-emitted member;
- diagnostics: any unsupported compression, timestamp, comment, Zip64,
  encryption, or permission metadata.

## Raw-Copy Provider

A later provider may preserve unchanged compressed bytes by combining:

1. ZIP inventory offsets from the parser;
2. direct byte copying for unchanged local headers and member data;
3. generated local headers for changed members;
4. a freshly written central directory and end-of-central-directory record.

That provider can offer stronger preservation evidence than a canonical rewrite
provider, but it is not required for the first writable ZIP slice.

## Safety

Every provider result must be parsed again after rendering. Final application is
rejected unless the rendered archive is readable and its inventory matches the
reviewed plan.
