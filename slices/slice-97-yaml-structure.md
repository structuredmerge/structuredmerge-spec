## Slice 97: YAML Structure

Define stable owner extraction for YAML mappings and sequences.

### Why

- merge and matching need a stable observable ownership model
- YAML nested mappings and sequences pressure ownership differently than TOML tables

### Rules

1. YAML owner paths use `/`-prefixed stable paths
2. nested mappings emit owner kind `mapping`
3. scalar or sequence-valued keys emit owner kind `key_value`
4. sequence items emit owner kind `sequence_item`
5. owner ordering is stable path order

### Notes

- this slice covers only the baseline supported YAML value subset
- aliases, tags, and non-string mapping keys are out of scope for this MVP slice
