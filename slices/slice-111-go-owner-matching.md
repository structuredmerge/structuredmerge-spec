## Slice 111: Go Owner Matching

Define the baseline owner matching contract for Go source files.

### Why

- the source-language widening path should keep the same narrow matching baseline
- exact stable-path matching remains the portable first step

### Rules

1. owners match by exact path equality
2. matched owners report `[template_path, destination_path]`
3. unmatched owners are reported in source-family owner order

### Notes

- content-aware or signature-aware refinement is out of scope
