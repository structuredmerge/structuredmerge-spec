# Slice 06: Parser Adapter Contracts

## Goal

Introduce a shared adapter contract between analysis libraries and concrete
parser backends.

## Planned Scope

- parser adapter interface shape
- grammar or dialect selection input
- adapter-owned diagnostics surface
- mapping from backend failure to shared parse-result vocabulary

## Shared Behavior

This slice defines a portable adapter contract:

1. every parse call is driven by a `ParserRequest`
2. the request includes `source`, `language`, and optional `dialect`
3. every adapter exposes descriptive metadata about the backend it fronts
4. adapter-level failures map into the shared parse-result and diagnostic model

## Shared Types

- `ParserRequest`
- `AdapterInfo`
- `ParserDiagnostics`
- `ParserAdapter`

## Why This Slice Exists

Slices 02 through 04 showed that portable observable behavior can be aligned
before tree-sitter integration details are aligned. This slice should preserve
that separation by specifying adapter behavior after parse contracts, not
before.

## Notes

- This slice does not require tree-sitter yet.
- It does require that future tree-sitter or native adapters fit the same
  observable request and result contract.
