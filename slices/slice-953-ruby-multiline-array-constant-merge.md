## Slice 953: Ruby Multiline Array Constant Merge

Merge matched direct class/module multiline array constants by preserving
destination elements and appending template-only elements before the closing
bracket.

### Why

- slice 952 covers compact one-line array constants
- Ruby class/module constants are often formatted as multiline lists
- formatting-preserving merge needs the multiline layout case before broader
  expression matching

### Rules

1. direct class/module body array constants are matched by constant name
2. destination array elements preserve their source text and order
3. template-only array elements are appended before the destination closing
   bracket in template order
4. destination indentation and trailing comma style are preserved for existing
   elements

### Notes

- This slice covers one scalar element per line.
