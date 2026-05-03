# Slice 677: Structured Edit CRISPR Overmatch Fail Closed

## Goal

Standardize the fail-closed outcome when a CRISPR-style targeted edit matches
more structural owners than the selector cardinality allows.

## Shared Behavior

This slice defines one shared overmatch failure outcome:

1. the targeted edit request carries a selector with exact-cardinality intent,
2. execution fails when the selector resolves more matches than allowed,
3. the failure preserves the original content unchanged and reports the
   observed match count.

## Notes

- This slice is anchored in the shared `ast-crispr` overmatch example rather
  than in parser-specific behavior.
