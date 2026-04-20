## Slice 96: YAML Parse

Define the baseline parse contract for YAML.

### Why

- YAML is the next real structured config family after TOML
- parsing pressure should land before ownership or merge semantics

### Rules

1. a successful YAML parse returns root kind `mapping`
2. comments are accepted as part of baseline YAML parsing
3. malformed YAML reports `parse_error`
4. the baseline family supports only mapping-root YAML documents

### Notes

- this slice does not define tree-sitter-backed YAML parsing
- baseline parsing may use native YAML libraries in each host language
