## Slice 962: Ruby Multiline Array No-Trailing-Comma Merge

Merge multiline Ruby array constants while preserving a destination style that
omits the final trailing comma.

### Why

- slice 953 covers multiline arrays with trailing commas
- Ruby codebases may omit the final trailing comma in multiline arrays
- appending template-only elements must add separator commas where needed
  without forcing a trailing comma style

### Rules

1. matched multiline array constants are merged by constant name
2. destination element order and indentation are preserved
3. when the destination omits the final trailing comma, the previous final
   element gains a separator comma and the new final element omits it
4. when the destination uses trailing commas, inserted template-only elements
   keep that style
