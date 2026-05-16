## Slice 952: Ruby Class Array Constant Merge

Merge matched direct class/module array constants by preserving destination
elements and appending template-only elements.

### Why

- slice 951 inserts template-only constants
- matched constants with structured values need a first expression-level merge
  beyond hash leaf merging

### Rules

1. direct class/module body array constants are matched by constant name
2. destination array elements preserve their source text and order
3. template-only array elements are appended in template order
4. scalar destination constant assignments continue to win over scalar template
   assignments

### Notes

- This slice covers one-line array literals with scalar source elements.
- Multi-line arrays and non-scalar array elements remain future fixtures.
