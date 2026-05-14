# Slice 745: JSON Object Match Refiner Evaluation

## Goal

Evaluate the old `Json::Merge::ObjectMatchRefiner` against current
structured-merge JSON conformance behavior.

The old Ruby implementation offered fuzzy matching for object members and
array object elements. Current JSON packages in the active Go, Rust,
TypeScript, and Ruby lanes only expose exact owner/path matching and
destination-wins merge behavior. This slice records that gap before any README
or API claims are ported.

## Old Behavior

The old `ObjectMatchRefiner`:

- matched object pairs by normalized key-name similarity,
- normalized camelCase, snake_case, kebab-case, and case differences,
- weighted key similarity and value similarity,
- accepted matches at a configurable threshold,
- greedily matched each template and destination node at most once,
- attempted object element matching for arrays by object key overlap,
- exposed Ruby-specific constructor options:
  `threshold`, `key_weight`, and `value_weight`.

## Current Behavior

Current JSON conformance behavior:

- records JSON owners as object members and array elements,
- matches owners by exact path equality,
- merges objects recursively with destination-owned scalar conflicts winning,
- keeps destination arrays when both template and destination define the same
  array owner,
- does not expose a fuzzy JSON owner matcher or `ObjectMatchRefiner`
  equivalent in any active language implementation.

## Decision

The old refiner should not be documented as current behavior yet.

The transferable value is a future JSON fuzzy-owner-matching feature, not the
old Ruby class shape. Before implementation, add portable fixtures for:

1. accepted camelCase to snake_case member matching,
2. rejected low-score member matching,
3. configurable threshold behavior,
4. key-weight versus value-weight scoring behavior,
5. greedy one-to-one matching,
6. public diagnostic/report output for fuzzy match decisions.

The old Ruby option names may be used as migration clues, but the new public
API names should be selected through active language package design rather than
copied from the old Ruby class.

## Boundaries

- This slice does not add a current JSON merge feature.
- Array object element matching is evaluated separately because the existing
  JSON array policy is destination-wins and does not currently merge individual
  array elements.
- README examples must remain silent about fuzzy JSON matching until fixtures
  and implementations exist.
