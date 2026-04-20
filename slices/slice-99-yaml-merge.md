## Slice 99: YAML Merge

Define the baseline recursive YAML mapping merge.

### Why

- YAML is the second post-JSON config family pressure test for recursive merge
- the merge should stay narrow and deterministic

### Rules

1. mappings merge recursively by key
2. overlapping scalar values prefer destination values
3. sequences prefer the entire destination sequence
4. template-only keys are preserved
5. destination-only keys are preserved
6. malformed template input reports `parse_error`
7. malformed destination input reports `destination_parse_error`

### Notes

- baseline rendering is canonical YAML for the supported subset
- fallback and repair policy are out of scope for this slice
