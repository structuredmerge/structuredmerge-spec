# Slice 09: JSON Merge Resolution

## Goal

Define the first end-to-end JSON merge-resolution contract.

## Planned Scope

- recursive merge for object members
- destination-wins behavior for overlapping scalars and arrays
- preservation of template-only object members
- deterministic rendered output for fixture comparison

## Shared Behavior

This slice defines a deliberately small merge rule:

1. if both values are objects, merge recursively by key
2. if both values are arrays, preserve the destination array
3. if both values are scalars, preserve the destination value
4. keys present only in the template are added
5. keys present only in the destination are preserved
6. rendered output is canonicalized with stable object-key ordering

## Shared Types

- `merge_json` or equivalent host-language function
- `JsonMergeResolution` or equivalent result wrapper where needed

## Notes

- This slice is intentionally object-centric.
- It does not yet attempt array-element merge semantics.
