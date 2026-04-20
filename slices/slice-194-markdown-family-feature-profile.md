# Slice 194: Markdown Family Feature Profile

## Goal

Expose the shared feature profile for the Markdown family.

## Shared Behavior

This slice defines one Markdown family contract:

1. the family identity is `markdown`,
2. the family exposes the single dialect `markdown`,
3. the initial portable surface is analysis and matching, not merge policy.

## Notes

- Markdown is intentionally starting with a narrower portable role set than the
  config and source-language families.
- This keeps the early substrate honest while parser plurality is being
  widened.
