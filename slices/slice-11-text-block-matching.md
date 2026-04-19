# Slice 11: Text Block Matching

## Goal

Define the first explicit matching contract over text blocks.

## Planned Scope

- exact normalized block matching
- destination-order preservation
- explicit matched and unmatched block reporting
- fixture cases for repeated and unmatched blocks

## Shared Behavior

This slice defines a deliberately narrow block-matching contract:

1. analyze template and destination into normalized blocks
2. match blocks by exact normalized content
3. preserve destination order in the matched result sequence
4. use first-unmatched occurrence semantics for duplicate normalized blocks
5. report:
   - matched block index pairs
   - unmatched template block indexes
   - unmatched destination block indexes

## Shared Types

- `TextBlockMatch`
- `TextBlockMatchResult`
- `match_text_blocks` or equivalent host-language function

## Notes

- This aligns with the current Ruby text resolver more closely than positional
  matching alone.
- Fuzzy or similarity-assisted refinement is deferred to a later slice.
