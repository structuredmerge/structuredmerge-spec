## Slice 942: Ruby Template-Only Method Visibility Ordering

Preserve Ruby method visibility when inserting template-only class/module
methods.

### Why

- slice 941 inserts template-only methods into matched class/module bodies
- blindly appending those methods before the final `end` can move public
  template methods under destination `private` or `protected` sections

### Rules

1. template-only direct methods with default public visibility are inserted
   before the first direct destination `private` or `protected` section marker
2. when no such marker exists, slice 941 insertion-before-closing-`end` behavior
   remains unchanged
3. destination-owned private/protected methods preserve their existing source
   text and ordering
4. inserted template methods preserve their template source text and indentation

### Notes

- This slice does not yet model template-owned private/protected methods.
- Explicit visibility grouping and method-list visibility calls remain future
  refiners.
