# Slice 973: Ruby Percent Array Custom Delimiter Merge

Merge matched Ruby percent word/symbol array constants that use non-paired
custom delimiters.

## Contract

1. matched direct class/module constants using custom delimiter forms such as
   `%w|...|`, `%i!...!`, `%W~...~`, or `%I/.../` are recognized as array
   constants
2. destination elements keep their order and spelling
3. template-only elements are appended in template order
4. destination custom delimiter form is preserved

## Fixture

`fixtures/ruby/slice-973-percent-array-custom-delimiter-merge/percent-array-custom-delimiter-merge.json`
