## Slice 101: TypeScript Family Feature Profile

Define the baseline feature profile for the TypeScript merge family.

### Why

- TypeScript is the first source-language family in the widening path
- the family profile should land before structure or merge behavior

### Rules

1. the family name is `typescript`
2. supported dialects are exactly `["typescript"]`
3. the baseline list policy is `destination_wins_array`
4. no fallback policy is declared in the baseline profile

### Notes

- this slice declares the family profile only
- module analysis, matching, and merge behavior are defined in later slices
