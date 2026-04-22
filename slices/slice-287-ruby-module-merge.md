## Slice 287: Ruby Module Merge

Define the baseline module-level merge for Ruby.

### Why

- Ruby family coverage currently stops at analysis, matching, and delegated
  child workflows
- the family needs one direct end-to-end merge contract with two source
  documents and one merged output

### Rules

1. `require` and `require_relative` lines prefer the entire destination require
   section
2. matched declarations prefer destination declaration text
3. unmatched template declarations are preserved
4. unmatched destination declarations are preserved
5. malformed template input reports `parse_error`
6. malformed destination input reports `destination_parse_error`

### Notes

- declaration rendering is source-preserving by extracted spans
- formatter-aware rewrite and deeper block-aware merge remain out of scope
