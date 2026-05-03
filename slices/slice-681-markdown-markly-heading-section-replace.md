# Slice 681: Markdown Markly Heading Section Replace

## Goal

Standardize the Markly-specific CRISPR replacement outcome for one
heading-owned Markdown section.

## Shared Behavior

This slice defines one shared Markdown/Markly heading-section replace
surface:

1. the selector resolves one heading-owned section branch by heading text and
   level,
2. replacement rewrites only the targeted section branch,
3. sibling sections remain unchanged.

## Notes

- This slice is anchored directly in the reference
  `ast-crispr-markdown-markly` replace example.
