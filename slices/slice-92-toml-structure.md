## Slice 92: TOML Structure

Define stable owner extraction for TOML tables and arrays.

### Why

- merge and matching need a stable observable ownership model
- TOML nested tables pressure ownership differently than JSON objects

### Rules

1. TOML owner paths use `/`-prefixed stable paths
2. nested tables emit owner kind `table`
3. scalar or array-valued keys emit owner kind `key_value`
4. array items emit owner kind `array_item`
5. owner ordering is stable path order

### Notes

- this slice covers only the baseline supported TOML value subset
- arrays of tables are out of scope for this MVP slice
