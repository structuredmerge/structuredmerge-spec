## Slice 90: TOML Family Feature Profile

Define the baseline feature profile for the TOML merge family.

### Why

- widen the structured family surface beyond json and text
- pressure the family-profile contract with a second real config format
- keep the first TOML release intentionally narrow and deterministic

### Rules

1. the family name is `toml`
2. supported dialects are exactly `["toml"]`
3. the baseline array policy is `destination_wins_array`
4. no fallback policy is declared in the baseline profile

### Notes

- this slice declares the family profile only
- parse, structure, matching, and merge behavior are defined in later slices
