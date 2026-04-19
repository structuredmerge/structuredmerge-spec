# Slice 06: Parser Adapter Contracts

## Goal

Introduce a shared adapter contract between analysis libraries and concrete
parser backends.

## Planned Scope

- parser adapter interface shape
- grammar or dialect selection input
- adapter-owned diagnostics surface
- mapping from backend failure to shared parse-result vocabulary

## Why This Slice Exists

Slices 02 through 04 showed that portable observable behavior can be aligned
before tree-sitter integration details are aligned. This slice should preserve
that separation by specifying adapter behavior after parse contracts, not
before.
