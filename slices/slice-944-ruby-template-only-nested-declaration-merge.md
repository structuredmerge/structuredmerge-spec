## Slice 944: Ruby Template-Only Nested Declaration Merge

Insert template-only nested class/module declarations into matched Ruby
namespace declarations.

### Why

- slice 943 recursively merges matched nested class/module declarations
- namespace-style Ruby code also needs missing template nested declarations to
  appear inside the matched parent namespace instead of at the top level

### Rules

1. direct nested class/module declarations are matched by declaration path/name
2. destination-owned nested declarations preserve their source text and order
3. template-only direct nested declarations are inserted before the destination
   parent declaration's closing `end`
4. inserted nested declarations preserve their template source text and
   indentation

### Notes

- This slice does not yet sort nested declarations or place them relative to
  constants and visibility sections beyond the existing body insertion boundary.
- Fuzzy/moved nested declaration matching remains future work.
