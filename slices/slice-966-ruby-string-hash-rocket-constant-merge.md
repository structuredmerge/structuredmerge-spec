# Slice 966: Ruby String Hash Rocket Constant Merge

Merge matched Ruby hash constants that use exact string hash-rocket keys.

## Contract

1. hash constants using string hash-rocket keys such as `"name" => value` are
   recognized as mergeable hash constants
2. string hash-rocket keys match only by exact key literal content
3. destination values win for matched keys
4. template-only string-key entries are appended in template order
5. rendered output preserves hash-rocket spelling for string keys

## Fixture

`fixtures/ruby/slice-966-string-hash-rocket-constant-merge/string-hash-rocket-constant-merge.json`
