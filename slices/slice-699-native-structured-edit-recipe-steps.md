# Slice 699: Native Structured-Edit Recipe Steps

## Goal

Represent `replace`, `insert`, and `delete` as native content-recipe steps using
the shared structured-edit request, result, and application contracts.

## Shared Behavior

This slice defines one shared native-step execution surface:

1. a recipe step with `step_kind: structured_edit` carries a
   `structured_edit_request`,
2. the step report carries the corresponding `structured_edit_application`,
3. step input and output content match the application request content and
   result updated content,
4. a single content recipe can execute `replace`, `insert`, and `delete` in
   order,
5. `delete` is the only canonical removal operation kind.

## Notes

- This slice makes the recipe pipeline consume the CRISPR triad from slice 695
  directly instead of treating it as a standalone report.
- `remove` is intentionally absent from the wire/API vocabulary.
