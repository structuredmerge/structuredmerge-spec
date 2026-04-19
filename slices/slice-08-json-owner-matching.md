# Slice 08: JSON Owner Matching

## Goal

Define the first explicit matching contract over JSON structural owners.

## Planned Scope

- baseline owner matching by stable path equality
- explicit matched and unmatched owner reporting
- fixture cases for identical and divergent owner sets

## Shared Behavior

This slice defines a deliberately narrow matching contract:

1. owners are matched by exact path equality
2. `match_key` remains an exposed candidate for later slices, but is not yet a
   standalone match rule
3. matching reports:
   - matched path pairs
   - unmatched template owner paths
   - unmatched destination owner paths

## Shared Types

- `JsonOwnerMatch`
- `JsonOwnerMatchResult`
- `match_json_owners` or equivalent host-language function

## Notes

- This slice chooses path equality first because slices 04 through 07 proved
  path stability before they proved higher-order owner equivalence rules.
- Later slices may add richer matching policies for arrays and reordered or
  semantically equivalent object regions.
