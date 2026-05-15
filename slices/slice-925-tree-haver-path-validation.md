# Slice 925: tree_haver Path Validation

## Status

Accepted for implementation.

## Context

Old tree_haver guarded grammar/library loading with path, language, symbol, and
backend-name validation. Active tree_haver keeps the security model portable so
backend discovery can reject unsafe inputs before trying to load native code or
derive grammar identifiers.

## Contract

Each implementation exposes:

- shared-library path validation,
- language-name validation,
- symbol-name validation,
- backend-name validation, and
- language-name sanitization.

Library path validation rejects nil/empty paths, excessive path length, null
bytes, relative paths, traversal segments, unsupported extensions, and unsafe
filenames. Validators report every independently detectable error in a stable
order so callers can surface complete remediation diagnostics. Versioned `.so.N`
paths are accepted.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-925-tree-haver-path-validation/path-validation.json`.
