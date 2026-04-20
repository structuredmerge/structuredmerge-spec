## Slice 103: TypeScript Owner Matching

Match TypeScript module owners by stable-path equality.

### Why

- the first source-language family should start with the same narrow matching baseline as config families
- import sections and declarations need explicit unmatched reporting before merge

### Rules

1. TypeScript owners match by exact stable path equality
2. matched results preserve template/destination path pairs
3. unmatched template and destination paths are reported explicitly

### Notes

- import normalization beyond extracted names is out of scope
- content refinement is not part of the baseline TypeScript path
