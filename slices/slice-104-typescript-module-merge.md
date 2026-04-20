## Slice 104: TypeScript Module Merge

Define the baseline module-level merge for TypeScript.

### Why

- the first source-language merge should stay narrow and deterministic
- module-level ownership gives a useful first source-language pressure test without full-AST rewrite semantics

### Rules

1. imports prefer the entire destination import section
2. matched declarations prefer destination declaration text
3. unmatched template declarations are preserved
4. unmatched destination declarations are preserved
5. malformed template input reports `parse_error`
6. malformed destination input reports `destination_parse_error`

### Notes

- declaration rendering is source-preserving by extracted spans
- body-aware merge and formatter-aware rewrite are out of scope
