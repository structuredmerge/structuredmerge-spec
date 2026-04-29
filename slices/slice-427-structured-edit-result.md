# Slice 427: Structured Edit Result

## Goal

Expose the first portable structured-edit result contract for CRISPR-style
edit execution.

## Shared Behavior

This slice defines one structured-edit result contract:

1. a result reports one `operation_kind`,
2. it reports the resulting `updated_content`,
3. it reports whether the edit `changed` the content,
4. it may report `captured_text`,
5. it may report `match_count`,
6. it may report one `operation_profile`,
7. it may report one `destination_profile`,
8. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice normalizes the common legacy CRISPR actor outputs into one
  portable result object.
- It does not require a shared executor yet; it only stabilizes result shape.
