# Slice 732: ZIP renderer and central-directory rewrite

## Goal

Render ZIP archives from a reviewed ZIP merge plan while preserving unchanged
compressed bytes wherever possible.

## Contract

The ZIP renderer must:

1. copy preserved local-header and member-data ranges for unchanged entries;
2. write new local headers and member bytes for added, rewritten, or delegated
   entries;
3. update CRC32, compressed size, uncompressed size, and offsets;
4. rewrite the central directory and end-of-central-directory records;
5. preserve supported archive comments;
6. emit a binary merge report with preserved ranges, rewritten nodes, checksum
   updates, nested dispatches, and diagnostics.

## Safety

Rendering must fail closed when the plan contains unresolved rejects, unsupported
compression methods, encrypted members, split archives, Zip64 fields that the
implementation cannot faithfully round-trip, or signing-sensitive derived-format
members without an explicit family opt-in.

## Verification

Rendered archives must be readable by the host ZIP implementation and must
round-trip unchanged members byte-for-byte when the plan says they were
preserved.
