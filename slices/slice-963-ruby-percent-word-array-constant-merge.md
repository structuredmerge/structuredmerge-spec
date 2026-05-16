## Slice 963: Ruby Percent Word Array Constant Merge

Merge matched Ruby percent word/symbol array constants such as `%w[...]` and
`%i[...]` by appending template-only elements.

### Why

- Ruby constants commonly use percent word arrays for compact lists
- these arrays should participate in the same constant merge behavior as
  bracket arrays
- preserving the destination literal form avoids unnecessary formatting churn

### Rules

1. matched direct class/module constants using `%w[...]` or `%i[...]` are
   recognized as array constants
2. destination elements preserve order and literal form
3. template-only elements append in template order
4. destination scalar constants and unsupported array forms remain
   destination-owned
