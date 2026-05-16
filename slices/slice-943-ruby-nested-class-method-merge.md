## Slice 943: Ruby Nested Class Method Merge

Extend recursive Ruby class/module body merge into matched nested
class/module declarations.

### Why

- slice 941 merges direct methods inside a matched class/module
- real Ruby source commonly nests classes and modules under namespace
  declarations
- treating the outer declaration as opaque still drops template-only methods
  inside matched nested declarations

### Rules

1. direct nested class/module declarations are matched by declaration path/name
2. matched nested declarations recursively apply the same body merge rules as
   top-level matched declarations
3. destination-owned nested methods preserve their source text
4. template-only direct methods inside a matched nested declaration are inserted
   before the nested declaration's closing `end`

### Notes

- This slice does not yet cover template-only nested declarations.
- Fuzzy class/module matching and moved nested declarations remain future
  refiners.
