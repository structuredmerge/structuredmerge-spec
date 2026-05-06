# Slice 724: ZIP family contract

ZIP archives are the first real binary family layered on the binary core
contract. The family covers ZIP-derived package/container formats such as JAR,
WAR, EAR, APK, AAB, EPUB, OOXML, ODF, and packaged configuration bundles.

The contract adds:

1. archive entries keyed by normalized path, with directory status, compression
   method, sizes, CRC32, and byte ranges for the local header, member data, and
   central-directory record;
2. member merge decisions for preserve, add, delete, delegate, rewrite, and
   reject operations;
3. nested-family dispatch for safe structured members such as text, XML, JSON,
   YAML, TOML, Ruby, Go, Rust, TypeScript, or Markdown;
4. archive merge reports that reuse binary preserved ranges, rewritten nodes,
   checksum/length updates, nested dispatches, and diagnostics.

The default safety posture preserves compressed bytes for unchanged members and
requires the ZIP renderer to rewrite the central directory whenever entries are
added, deleted, renamed, recompressed, or receive delegated content changes.
Executable or signing-sensitive members are rejected unless a ZIP-derived format
family explicitly enables the operation.
