# Slice 423: Structured Edit Destination Profile

## Goal

Expose the portable destination-resolution profile for structured-edit
insertions and moves.

## Shared Behavior

This slice defines one structured-edit destination-profile contract:

1. a destination profile identifies one `resolution_kind`,
2. it identifies one `resolution_source`,
3. it identifies one `anchor_boundary`,
4. it reports `resolution_family`,
5. it reports `resolution_source_family`,
6. it reports `anchor_boundary_family`,
7. it reports whether those values are known through the matching
   `known_*` flags,
8. it reports whether fallback was used through `used_if_missing`,
9. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice describes destination resolution after selection but before edit
  result reporting.
- It is expected to support both selector-resolved and callable-resolved
  destinations.
