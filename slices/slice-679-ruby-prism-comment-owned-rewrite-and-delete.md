# Slice 679: Ruby Prism Comment Owned Rewrite And Delete

## Goal

Standardize the Prism-specific CRISPR outcomes for comment-region-owned
replacement and deletion of one structurally owned Ruby span.

## Shared Behavior

This slice defines one shared Ruby/Prism comment-owned rewrite/delete
surface:

1. the selector resolves one leading-comment-owned structural owner span,
2. replacement rewrites that span without disturbing unrelated Ruby code,
3. deletion removes that span, including the managed marker, without
   disturbing unrelated Ruby code.

## Notes

- This slice is anchored directly in the reference `ast-crispr-ruby-prism`
  examples.
