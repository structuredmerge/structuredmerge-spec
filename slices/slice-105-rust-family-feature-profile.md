## Slice 105: Rust Family Feature Profile

Define the first source-language family feature profile for Rust.

### Why

- Rust is the next source-language family in the widening path
- the same family profile contract should survive across another code-language family

### Rules

1. the family name is `rust`
2. supported dialects are exactly `["rust"]`
3. the baseline supported policy set is:
   - `destination_wins_array`

### Notes

- this slice is intentionally narrow
- richer Rust-specific policy surfaces remain out of scope
