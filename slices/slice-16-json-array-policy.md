# Slice 16: JSON Array Policy

## Goal

Define the first explicit JSON array policy contract.

## Planned Scope

- make the current destination-wins array behavior explicit as a named baseline
  policy
- expose array handling separately from object merge semantics
- keep array handling observable without introducing element-level array merge
  yet

## Shared Behavior

This slice defines one baseline array policy:

1. when both template and destination values are arrays, the destination array
   is preserved as a whole
2. the template array is not appended to, interleaved with, or element-matched
   against the destination array
3. array policy applies recursively inside enclosing object merges
4. canonical render remains the comparison surface for merged output

## Shared Types

- `merge_json` or equivalent host-language function
- `MergeResult` or equivalent result wrapper

## Notes

- This slice names the current behavior rather than changing it.
- Future slices may introduce alternative array policies, but this slice keeps
  the baseline explicit.
