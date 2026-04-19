# Slice 16: JSON Array Policy

## Goal

Plan the first explicit array-policy slice for JSON merge.

## Planned Scope

- make the current destination-wins array behavior explicit as an array policy
- expose that policy separately from object merge semantics
- prepare for future alternative array policies without changing baseline
  meaning

## Intended Direction

This slice should:

1. define a named baseline array policy for JSON merge
2. make array handling observable in fixtures without requiring element-level
   matching yet
3. preserve canonical render comparison

## Notes

- The current implementation already behaves as destination-wins for arrays.
- The next step is to make that a first-class policy surface instead of an
  incidental branch inside object merge resolution.
