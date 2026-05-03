# Slice 680: Ruby Callable Destination Move Parity

## Goal

Standardize the Ruby-family CRISPR move outcome that removes a stale managed
Ruby span and reinserts new text at a callable destination anchor,
independent of the parser backend used to locate the source span.

## Shared Behavior

This slice defines one shared Ruby-family callable-destination move surface:

1. the source selector may match zero or one existing managed Ruby span,
2. the destination resolves from a callable anchor positioned after a Ruby
   statement boundary,
3. execution produces one managed span at the destination and reports a
   callable anchored destination profile,
4. the same scenario may be satisfied by any Ruby-capable backend that can
   expose the required owner, boundary, and anchor semantics.

## Notes

- This slice is anchored in the reference `ast-crispr-ruby-prism` move
  example, but it is not limited to Prism as an implementation backend.
