# Slice 972: Ruby Percent Array Alternate Delimiter Merge

Merge matched Ruby percent word/symbol array constants that use paired delimiters
other than brackets.

## Contract

1. matched direct class/module constants using `%w(...)`, `%i{...}`,
   `%W<...>`, or `%I(...)` are recognized as array constants
2. destination elements keep their order and spelling
3. template-only elements are appended in template order
4. destination percent-array delimiter form is preserved

## Fixture

`fixtures/ruby/slice-972-percent-array-alternate-delimiter-merge/percent-array-alternate-delimiter-merge.json`
