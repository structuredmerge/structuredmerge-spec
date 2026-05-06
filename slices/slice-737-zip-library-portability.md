# Slice 737: ZIP library portability

## Goal

Port the ZIP merge library surface from the Go prototype into Ruby, Rust, and
TypeScript.

## Contract

Each implementation must expose the same family-facing concepts:

1. ZIP inventory parsing with local-header, data, and central-directory ranges;
2. member planning for preserve, delegate, rewrite, add, delete, and reject;
3. unsafe entry detection for traversal, duplicate normalized paths, encrypted
   members, and signing-sensitive members;
4. nested dispatch for structured member paths such as Markdown, JSON, YAML, and
   XML;
5. raw-preservation success evidence and fail-closed diagnostics for the shared
   slice-736 edge-case fixture.

## Scope

The first portability slice may implement a conservative stored/deflated subset
per host language. Implementations must reject unsupported raw-preservation
features rather than silently rewriting or dropping metadata.
