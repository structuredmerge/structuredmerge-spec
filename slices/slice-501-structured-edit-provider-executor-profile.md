# Slice 501: Structured Edit Provider Executor Profile

## Goal

Expose one portable executor-capability profile for a concrete structured-edit
provider backend.

## Shared Behavior

This slice defines one structured-edit provider executor-profile contract:

1. it identifies one `provider_family`,
2. it identifies one `provider_backend`,
3. it identifies one `executor_label`,
4. it carries one shared `structure_profile`,
5. it carries one shared `selection_profile`,
6. it carries one shared `match_profile`,
7. it carries ordered shared `operation_profiles`,
8. it carries one shared `destination_profile`,
9. it may carry implementation metadata without changing the portable shape.

## Notes

- This slice standardizes executor capability description, not executor
  dispatch.
- It is the first portable discovery surface for the future `ast-crispr`
  plugin layer.
