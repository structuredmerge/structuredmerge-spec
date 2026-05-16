## Slice 951: Ruby Template-Only Class Constant Merge

Insert template-only direct constant assignments into matched Ruby class/module
bodies.

### Why

- recursive class/module merge now covers methods and nested declarations
- constants are a common class/module body element and should not be dropped
  when the parent declaration exists on both sides

### Rules

1. direct class/module body constant assignments are matched by constant name
2. destination-owned constant assignments preserve their source text
3. template-only direct constant assignments are inserted before method and
   visibility-section insertion boundaries
4. inserted constant assignment text preserves template source indentation

### Notes

- This slice covers direct constant assignment insertion only.
- Existing matched constant hash leaf merge remains covered by slice 720.
