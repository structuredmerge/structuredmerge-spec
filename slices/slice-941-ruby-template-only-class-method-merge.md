## Slice 941: Ruby Template-Only Class Method Merge

Define the first recursive Ruby class/module body merge beyond destination-wins
top-level declaration replacement.

### Why

- slice 287 keeps matched destination declarations intact, which drops
  template-only methods inside a matched class or module
- Ruby tooling needs source-preserving recursive merge before method/class
  refiners can be evaluated honestly

### Rules

1. matched top-level class/module declarations preserve destination-owned method
   bodies
2. methods present only in the template class/module body are inserted before the
   destination declaration's closing `end`
3. direct method identity is the method name for this slice
4. inserted template methods preserve their template source text and indentation
5. malformed template input reports `parse_error`
6. malformed destination input reports `destination_parse_error`

### Notes

- This slice intentionally covers only direct class/module body methods.
- Constructor-aware, fuzzy, moved-method, nested class/module, singleton-method,
  visibility-section, and comment-attachment refiners remain future fixtures.
