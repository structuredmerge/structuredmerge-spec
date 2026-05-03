# Slice 679: Ruby Comment Owned Rewrite And Delete Parity

## Goal

Standardize Ruby-family CRISPR outcomes for comment-region-owned replacement
and deletion of one structurally owned Ruby span, independent of the parser
backend used to discover that span.

## Shared Behavior

This slice defines one shared Ruby-family comment-owned rewrite/delete
surface:

1. the selector resolves one leading-comment-owned structural owner span,
2. replacement rewrites that span without disturbing unrelated Ruby code,
3. deletion removes that span, including the managed marker, without
   disturbing unrelated Ruby code,
4. the same scenario may be satisfied by any Ruby-capable backend that can
   expose the required owner and comment-region semantics.

## Notes

- This slice is anchored in the reference `ast-crispr-ruby-prism` examples,
  but it is not limited to Prism as an implementation backend.
