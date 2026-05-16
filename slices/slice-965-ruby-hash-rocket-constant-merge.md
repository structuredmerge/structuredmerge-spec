# Slice 965: Ruby Hash Rocket Constant Merge

Merge matched Ruby hash constants that use hash-rocket keys.

## Contract

1. hash constants using symbol hash-rocket keys such as `:name => value` are
   recognized as mergeable hash constants
2. label-style symbol keys and symbol hash-rocket keys normalize to the same
   merge identity
3. destination values win for matched keys
4. template-only hash-rocket entries are appended in template order
5. rendered output preserves the destination hash-rocket spelling for existing
   destination keys and the template spelling for appended keys

## Fixture

`fixtures/ruby/slice-965-hash-rocket-constant-merge/hash-rocket-constant-merge.json`
