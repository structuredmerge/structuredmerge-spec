## Slice 954: Ruby Nested Class Constant Merge

Merge direct constants inside matched nested class/module declarations while
preserving destination-owned enclosing declaration text.

### Why

- slices 951-953 cover direct constants in a matched declaration body
- slice 943 proves recursive method merging for matched nested declarations
- constants need the same recursive declaration behavior before broader method
  and class refiners are added

### Rules

1. nested class/module declarations are matched by declaration path within the
   enclosing declaration
2. direct constants inside matched nested declarations are matched by constant
   name
3. destination-owned constants preserve their source text
4. template-only nested constants are inserted into the matched nested
   declaration body before methods and visibility sections
