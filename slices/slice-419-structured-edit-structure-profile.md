# Slice 419: Structured Edit Structure Profile

## Goal

Expose the first portable structure-profile contract for CRISPR-style
structured editing.

## Shared Behavior

This slice defines one structured-edit structure-profile contract:

1. a structure profile identifies the edit `owner_scope`,
2. it identifies the portable `owner_selector`,
3. it reports the selector family as `owner_selector_family`,
4. it reports whether the selector is known through `known_owner_selector`,
5. it lists supported `comment_regions`,
6. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice is the clean-room counterpart to the legacy CRISPR adapter
  structure profile.
- It defines profile shape only; it does not require parsing, matching, or edit
  execution yet.
