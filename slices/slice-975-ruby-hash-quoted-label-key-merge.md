# Slice 975: Ruby Hash Quoted Label Key Merge

Merge Ruby hash constants that use quoted label keys.

## Contract

1. quoted label keys such as `"timeout-ms":` and `'retry-mode':` are
   recognized as stable Ruby symbol keys
2. quoted label keys can match equivalent bare label keys when the symbol name
   is the same
3. destination values and key spelling win for keys already present in the
   destination
4. template-only keys are appended in template order while preserving their
   source key spelling

## Fixture

`fixtures/ruby/slice-975-hash-quoted-label-key-merge/hash-quoted-label-key-merge.json`
