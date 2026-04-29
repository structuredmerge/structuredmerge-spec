# Slice 426: Structured Edit Request

## Goal

Expose the first portable structured-edit request contract for CRISPR-style
edit execution.

## Shared Behavior

This slice defines one structured-edit request contract:

1. a request identifies one `operation_kind`,
2. it carries the source `content`,
3. it carries one `source_label`,
4. it may identify one `target_selector`,
5. it may report `target_selector_family`,
6. it may identify one `destination_selector`,
7. it may report `destination_selector_family`,
8. it may carry one `payload_text`,
9. it may carry one `if_missing` policy,
10. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice normalizes the legacy CRISPR actor inputs into one transportable
  request object.
- It defines request shape only; it does not require execution yet.
