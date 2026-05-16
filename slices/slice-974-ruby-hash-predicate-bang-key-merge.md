# Slice 974: Ruby Hash Predicate And Bang Key Merge

Merge Ruby hash constants that use method-style symbol keys ending in `?` or
`!`.

## Contract

1. label keys such as `enabled?:` and `sync!:` are recognized as stable Ruby
   hash keys
2. symbol hash-rocket keys such as `:enabled? =>` and `:sync! =>` are
   recognized as stable Ruby hash keys
3. destination values and key spelling win for keys already present in the
   destination
4. template-only keys are appended in template order while preserving their
   source key spelling

## Fixture

`fixtures/ruby/slice-974-hash-predicate-bang-key-merge/hash-predicate-bang-key-merge.json`
