## Slice 93: TOML Owner Matching

Match TOML owners by stable path equality.

### Why

- JSON already established exact-path owner matching as a portable baseline
- TOML should follow the same narrow matching rule before any refinement

### Rules

1. TOML owners match by exact stable path equality
2. matched results preserve template/destination path pairs
3. unmatched template and destination paths are reported explicitly

### Notes

- match-key refinement is not part of the baseline TOML path
- this slice intentionally mirrors the narrow JSON matching rule
