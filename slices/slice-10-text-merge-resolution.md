# Slice 10: Text Merge Resolution

## Goal

Define the first end-to-end text merge-resolution contract.

## Planned Scope

- blockwise merge over slice-03 text analysis
- destination-wins behavior for aligned blocks
- preservation of trailing unmatched blocks
- deterministic rendered output for fixture comparison

## Shared Behavior

This slice defines a deliberately small text merge rule:

1. analyze template and destination into normalized blocks
2. align blocks by position
3. when both sides have a block at the same position, preserve the destination block
4. when only one side has a block at a position, preserve that block
5. render the merged blocks joined by `\n\n`

## Shared Types

- `merge_text` or equivalent host-language function
- `TextMergeResolution` or equivalent result wrapper where needed

## Notes

- This slice does not yet use similarity to change merge outcomes.
- Similarity remains available as an advisory signal for later slices.
