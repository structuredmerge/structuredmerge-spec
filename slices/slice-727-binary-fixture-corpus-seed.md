# Slice 727: Binary fixture corpus seed

## Goal

Seed shared binary fixtures that exercise byte ranges, decoded scalar values,
preserved regions, diagnostics, and conservative render decisions before any
format-specific renderer is allowed to mutate bytes.

## Fixture Shape

The binary fixture corpus should include:

1. small raw-byte payloads represented as hex or base64;
2. expected byte ranges for known header, body, checksum, and footer regions;
3. decoded scalar examples for every `BinaryScalarValue` kind;
4. render-policy examples for preserve, rewrite, insert, delete, delegate, and
   reject;
5. diagnostics anchored to schema paths and optional byte ranges.

## Conformance

Ruby, Go, Rust, and TypeScript implementations should consume the same fixtures
through the existing conformance manifest role lookup. The first fixture can be
structural-only; later fixtures may add executable parser outputs once Kaitai
runtime bindings are present.

## Safety

Fixture expectations must prefer preservation and rejection over speculative
rewrites. A binary renderer must prove it can update dependent fields such as
lengths and checksums before a changed byte range becomes writable.
