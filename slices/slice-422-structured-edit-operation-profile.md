# Slice 422: Structured Edit Operation Profile

## Goal

Expose the portable operation-profile contract for structured-edit actors.

## Shared Behavior

This slice defines one structured-edit operation-profile contract:

1. an operation profile identifies one `operation_kind`,
2. it reports the operation family as `operation_family`,
3. it reports whether that kind is known through `known_operation_kind`,
4. it identifies `source_requirement`,
5. it identifies `destination_requirement`,
6. it identifies `replacement_source`,
7. it reports whether the operation captures source text,
8. it reports whether the operation supports `if_missing`,
9. it may carry implementation metadata without changing the portable shape.

## Notes

- The initial expected operation kinds are the legacy CRISPR set:
  `replace`, `delete`, `insert`, and `move`.
- This slice standardizes observable operation capability before defining
  execution requests or results.
