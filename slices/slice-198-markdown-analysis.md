# Slice 198: Markdown Analysis

## Goal

Define the first portable Markdown analysis shape.

## Shared Behavior

This slice defines one Markdown analysis contract:

1. the analysis root kind is `document`,
2. the first portable owner kinds are `heading` and `code_fence`,
3. owners are reported in source order with stable family paths.

## Notes

- This slice intentionally uses shared Markdown block analysis above parser
  backends.
- It is a substrate slice, not a claim that all Markdown parser ASTs are
  structurally identical.
