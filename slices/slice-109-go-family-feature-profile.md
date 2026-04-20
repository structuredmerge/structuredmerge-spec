## Slice 109: Go Family Feature Profile

Define the first source-language family feature profile for Go.

### Why

- Go is the third source-language family in the widening path
- the source-language family profile pattern should remain stable across another syntax family

### Rules

1. the family name is `go`
2. supported dialects are exactly `["go"]`
3. the baseline supported policy set is:
   - `destination_wins_array`

### Notes

- this slice remains intentionally narrow
- richer Go-specific policy surfaces are out of scope
