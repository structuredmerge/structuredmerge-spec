## Slice 94: TOML Merge

Define the baseline recursive TOML table merge.

### Why

- TOML is the first post-JSON config family pressure test for recursive merge
- the merge should stay narrow and deterministic

### Rules

1. tables merge recursively by key
2. overlapping scalar values prefer destination values
3. arrays prefer the entire destination array
4. template-only keys are preserved
5. destination-only keys are preserved
6. malformed template input reports `parse_error`
7. malformed destination input reports `destination_parse_error`

### Notes

- baseline rendering is canonical TOML for the supported subset
- fallback and repair policy are out of scope for this slice
