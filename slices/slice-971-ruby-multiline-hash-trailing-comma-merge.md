# Slice 971: Ruby Multiline Hash Trailing Comma Merge

Preserve destination trailing-comma style when merging multiline Ruby hash
constants.

## Contract

1. matched direct class/module hash constants are merged by constant name
2. nested hash keys are merged recursively
3. destination scalar values win for matched keys
4. template-only keys are appended in template order
5. when the destination multiline hash has a trailing comma on the last pair,
   the rendered merged hash keeps that trailing comma

## Fixture

`fixtures/ruby/slice-971-multiline-hash-trailing-comma-merge/multiline-hash-trailing-comma-merge.json`
