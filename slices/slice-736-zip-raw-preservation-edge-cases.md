# Slice 736: ZIP raw-preservation edge cases

## Goal

Close the gap between the initial raw-preserving ZIP renderer and production
support for less common ZIP features.

## Contract

The raw-preserving renderer must either faithfully preserve or explicitly reject:

1. Zip64 local headers, central-directory records, and end records;
2. archive comments and member comments;
3. extra fields on local headers and central-directory records;
4. data descriptors and general-purpose bit flag combinations;
5. encrypted members;
6. split or spanned archives;
7. unsupported compression methods;
8. signing-sensitive container formats such as JAR, APK, XPI, and signed OOXML
   packages;
9. executable permission or platform-attribute mutations;
10. duplicate normalized paths and traversal-sensitive paths.

## Verification

Fixtures must cover both successful preservation and fail-closed rejection.
Successful cases must prove:

- copied local records and compressed payloads are byte-identical;
- central-directory offsets and sizes are rewritten correctly;
- the rendered archive is readable by the host ZIP implementation;
- preservation evidence points back to source byte ranges.

Rejected cases must emit diagnostics that identify the unsupported feature and
the relevant schema path or byte range.
