# Slice 967: Ruby Uppercase Percent Array Constant Merge

Merge matched Ruby uppercase percent word/symbol array constants.

## Contract

1. matched direct class/module constants using `%W[...]` or `%I[...]` are
   recognized as array constants
2. destination elements keep their order and spelling
3. template-only elements are appended in template order
4. destination uppercase percent-array delimiters are preserved

## Fixture

`fixtures/ruby/slice-967-uppercase-percent-array-constant-merge/uppercase-percent-array-constant-merge.json`
