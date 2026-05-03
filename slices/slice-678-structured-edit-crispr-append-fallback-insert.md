# Slice 678: Structured Edit CRISPR Append Fallback Insert

## Goal

Standardize one CRISPR-style insert outcome that appends explicit text when
no destination anchor resolves and `if_missing` requests append fallback.

## Shared Behavior

This slice defines one shared append-fallback insert outcome:

1. the insert request carries explicit replacement text,
2. execution appends that text when no destination anchor is resolved,
3. the outcome reports append fallback instead of an anchored destination.

## Notes

- This slice is anchored in the shared `ast-crispr` insert example.
