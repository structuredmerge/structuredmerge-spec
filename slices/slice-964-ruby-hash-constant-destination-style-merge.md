# Slice 964: Ruby Hash Constant Destination Style Merge

Merge matched Ruby hash constants while preserving the destination hash layout
style.

## Contract

1. matched direct class/module hash constants are matched by constant name
2. nested hash keys are merged recursively
3. destination scalar values win for matched keys
4. template-only keys are appended in template order
5. the rendered hash preserves the destination inline/multiline style for each
   matched hash level

## Fixture

`fixtures/ruby/slice-964-hash-constant-destination-style-merge/hash-constant-destination-style-merge.json`
