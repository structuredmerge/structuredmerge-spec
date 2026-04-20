## Slice 98: YAML Owner Matching

Match YAML owners by stable path equality.

### Why

- JSON and TOML already established exact-path owner matching as a portable baseline
- YAML should follow the same narrow matching rule before any refinement

### Rules

1. YAML owners match by exact stable path equality
2. matched results preserve template/destination path pairs
3. unmatched template and destination paths are reported explicitly

### Notes

- match-key refinement is not part of the baseline YAML path
- this slice intentionally mirrors the narrow JSON and TOML matching rule
