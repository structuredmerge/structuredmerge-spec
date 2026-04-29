# Slice 421: Structured Edit Match Profile

## Goal

Expose the portable match-profile contract for structured-edit selections.

## Shared Behavior

This slice defines one structured-edit match-profile contract:

1. a match profile identifies one `start_boundary`,
2. it identifies one `end_boundary`,
3. it reports `start_boundary_family` and `end_boundary_family`,
4. it reports whether those boundaries are known through
   `known_start_boundary` and `known_end_boundary`,
5. it identifies one `payload_kind`,
6. it reports `payload_family` and `known_payload_kind`,
7. it reports whether the match is `comment_anchored`,
8. it reports whether the match is `trailing_gap_extended`,
9. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice standardizes what a selected span means.
- It does not yet define the transport shape for a resolved match instance or
  the execution semantics of an edit operation.
