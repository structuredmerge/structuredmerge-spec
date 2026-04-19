# Slice 13: Text Content-Refined Matching

## Goal

Add a second matching phase for text blocks so near-edited blocks can align
without weakening exact-match semantics.

## Planned Scope

- preserve slice-11 exact normalized block matching as the first phase
- run one greedy refinement pass only on unmatched blocks
- compute refined scores from content, length, and relative-position similarity
- keep exact and refined matches distinct in the observable result
- drive text merge from the combined exact-plus-refined match set

## Shared Behavior

This slice defines a portable content-refined matching rule:

1. perform exact normalized block matching using slice-11 behavior
2. collect unmatched template and destination blocks
3. compute a refined similarity score for each remaining candidate pair:
   `0.7 * content + 0.15 * length + 0.15 * position`
4. `content` is normalized Levenshtein similarity over the normalized block text
5. `length` is the ratio of shorter to longer normalized block length
6. `position` is `1 - abs(relative_template_position - relative_destination_position)`
7. greedily consume the best available refined match for each remaining
   destination block, subject to a threshold of `0.7`
8. emit exact and refined matches in destination order
9. report each match with its `phase`

## Shared Types

- `TextBlockMatch.phase` or equivalent host-language field with values
  `exact | refined`
- `refined_text_similarity` or equivalent host-language helper where useful

## Notes

- This slice does not introduce composite refiners or configurable pipelines.
- This slice supersedes slice-12 merge anchoring by allowing refined matches to
  suppress template-only replay for near-edited destination blocks.
