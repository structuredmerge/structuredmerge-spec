## Slice 108: Rust Module Merge

Define the baseline module-level merge for Rust.

### Why

- Rust is a useful second source-language merge pressure test
- module-level ownership keeps the merge narrow and deterministic

### Rules

1. imports prefer the entire destination `use` section
2. matched declarations prefer destination declaration text
3. unmatched template declarations are preserved
4. unmatched destination declarations are preserved
5. malformed template input reports `parse_error`
6. malformed destination input reports `destination_parse_error`

### Notes

- declaration rendering is source-preserving by extracted spans
- formatter-aware rewrite and block-aware merge remain out of scope
