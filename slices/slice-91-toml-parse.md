## Slice 91: TOML Parse

Define the baseline parse contract for TOML.

### Why

- TOML is the next real structured config family after JSON
- parsing pressure should land before ownership or merge semantics

### Rules

1. a successful TOML parse returns root kind `table`
2. comments are accepted as part of baseline TOML parsing
3. malformed TOML reports `parse_error`
4. the baseline family supports only table-root TOML documents

### Notes

- this slice does not define tree-sitter-backed TOML parsing
- baseline parsing may use native TOML libraries in each host language
