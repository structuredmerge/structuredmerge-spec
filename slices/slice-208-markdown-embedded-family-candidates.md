# Slice 208: Markdown Embedded Family Candidates

## Goal

Surface recognized embedded family candidates from Markdown code fences.

## Shared Behavior

This slice defines one embedded-family contract:

1. Markdown analysis MAY derive embedded family candidates from fenced code
   blocks.
2. Embedded family candidates are keyed by the code-fence owner path.
3. Embedded family candidates preserve the original fence language string.
4. A candidate MAY declare a more specific dialect when the fence language maps
   to a family variant such as `jsonc`.

## Notes

- This slice does not yet parse embedded code blocks with the child family.
- It only exposes the family-routing candidates that Markdown can surface from
  its own analysis.
