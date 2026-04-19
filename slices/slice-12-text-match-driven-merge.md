# Slice 12: Text Match-Driven Merge

## Goal

Replace positional text merge with a merge rule driven by validated block
matching.

## Planned Scope

- exact normalized block matching as the merge anchor
- destination-order preservation
- destination-wins behavior for matched blocks
- template-only block preservation after destination traversal

## Shared Behavior

This slice defines a match-driven text merge rule:

1. match blocks using slice-11 exact normalized matching
2. emit destination blocks in destination order
3. for matched blocks, emit the destination block content
4. for unmatched destination blocks, emit the destination block content
5. after destination traversal, append unmatched template blocks in template order
6. render the merged blocks joined by `\n\n`

## Shared Types

- `merge_text` or equivalent host-language function
- `TextMergeResolution` or equivalent result wrapper where needed

## Notes

- This slice supersedes the positional merge behavior from slice 10.
- It is intentionally exact-match based; fuzzy refinement remains a later slice.
