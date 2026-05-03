# Slice 680: Ruby Prism Callable Destination Move

## Goal

Standardize the Prism-specific CRISPR move outcome that removes a stale
managed Ruby span and reinserts new text at a callable destination anchor.

## Shared Behavior

This slice defines one shared Ruby/Prism callable-destination move surface:

1. the source selector may match zero or one existing managed Ruby span,
2. the destination resolves from a callable anchor positioned after a Ruby
   statement boundary,
3. execution produces one managed span at the destination and reports a
   callable anchored destination profile.

## Notes

- This slice is anchored directly in the reference `ast-crispr-ruby-prism`
  move example.
