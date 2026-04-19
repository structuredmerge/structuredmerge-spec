# Slice 02: Diagnostics And Results

## Goal

Define the first portable runtime contract shared by all implementations:

- diagnostics
- parse results
- merge results

## Scope

Included:

- normalized diagnostic severities
- normalized diagnostic categories
- minimal parse result shape
- minimal merge result shape
- fixture space for diagnostic expectations
- exported language-level types/structs/interfaces

Excluded:

- tree-sitter integration
- actual parser execution
- actual merge behavior
- render behavior

## Shared Diagnostic Vocabulary

Severity:

- `info`
- `warning`
- `error`

Categories:

- `parse_error`
- `destination_parse_error`
- `unsupported_feature`
- `fallback_applied`
- `ambiguity`

## Shared Result Vocabulary

### Parse Result

- `ok`
- `diagnostics`
- `analysis` or equivalent implementation payload

### Merge Result

- `ok`
- `diagnostics`
- `output` or equivalent rendered payload

## Conformance Objective

This slice succeeds when TypeScript, Rust, and Go all expose:

- the same severity values
- the same diagnostic categories
- a parse result type
- a merge result type

The exact host-language syntax can differ, but the underlying vocabulary should
remain aligned.
