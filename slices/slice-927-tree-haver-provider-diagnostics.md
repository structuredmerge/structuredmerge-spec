# Slice 927: tree_haver Provider Diagnostics

## Status

Accepted for implementation.

## Context

Provider metadata already carries plain diagnostic strings, but native and
multi-parser providers need richer diagnostics for backend selection, profile
promotion, and user-facing reports. The normalized tree remains the downstream
surface; provider-specific problems are projected into structured diagnostic
sidecars instead of exposing raw parser objects.

## Contract

Each implementation exposes provider diagnostics with:

- provider id,
- backend reference,
- language,
- structured diagnostics with severity, category, code, message, path, and
  blocking flag, and
- a derived status: `clean`, `warning`, or `blocked`.

Any blocking diagnostic makes the report `blocked`. Otherwise, warning
diagnostics make the report `warning`; an empty diagnostic list is `clean`.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-927-tree-haver-provider-diagnostics/provider-diagnostics.json`.
