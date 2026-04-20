## Slice 95: YAML Family Feature Profile

Define the baseline feature profile for the YAML merge family.

### Why

- widen the structured family surface beyond JSON and TOML
- pressure the family-profile contract with a second non-JSON config format
- keep the first YAML release narrow and deterministic

### Rules

1. the family name is `yaml`
2. supported dialects are exactly `["yaml"]`
3. the baseline sequence policy is `destination_wins_array`
4. no fallback policy is declared in the baseline profile

### Notes

- this slice declares the family profile only
- parse, structure, matching, and merge behavior are defined in later slices
