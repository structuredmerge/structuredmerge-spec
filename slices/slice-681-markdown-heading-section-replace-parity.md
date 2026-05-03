# Slice 681: Markdown Heading Section Replace Parity

## Goal

Standardize the Markdown-family CRISPR replacement outcome for one
heading-owned Markdown section, independent of the parser backend used to
discover that section.

## Shared Behavior

This slice defines one shared Markdown-family heading-section replace
surface:

1. the selector resolves one heading-owned section branch by heading text and
   level,
2. replacement rewrites only the targeted section branch,
3. sibling sections remain unchanged,
4. the same scenario may be satisfied by any Markdown-capable backend that
   can expose the required heading-section ownership semantics.

## Notes

- This slice is anchored in the reference `ast-crispr-markdown-markly`
  replace example, but it is not limited to Markly as an implementation
  backend.
