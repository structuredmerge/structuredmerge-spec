# Slice 729: ZIP fixture corpus seed

## Goal

Add shared ZIP fixtures that exercise archive inventory and conservative member
decisions before ZIP rendering is implemented.

## Fixture Shape

The ZIP fixture corpus should include:

1. a tiny archive with at least one stored text member and one directory entry;
2. a deflated member whose compressed bytes are preserved when unchanged;
3. expected ranges for local headers, member data, central directory entries,
   end-of-central-directory data, and archive comments when present;
4. normalized member paths;
5. CRC32, compressed size, uncompressed size, and compression method metadata;
6. member decisions for preserve, add, delete, delegate, rewrite, and reject.

## Derived Formats

The fixture vocabulary must leave room for ZIP-derived containers such as JAR,
WAR, EAR, APK, AAB, EPUB, OOXML, and ODF. Derived-format safety policy can
remain disabled until format-specific slices opt in.

## Safety

Signing-sensitive paths, executable paths, path traversal entries, duplicate
normalized paths, and encrypted members should be represented as rejected
fixtures before writable behavior is added.
