# Slice 970: Kettle/Jem Ruby Method Move Policy Override

Thread Ruby method move policy through Kettle/Jem per-file template strategy
configuration.

## Contract

1. Kettle/Jem template `files` and `patterns` strategy entries may set
   `method_move_policy` for Ruby-family merge targets
2. the initial supported policy is `destination_order`
3. the policy is passed to `Ruby::Merge.merge_ruby`
4. recipe reports expose the selected policy through
   `template_source_preference`
5. this keeps the default non-interactive and deterministic while preserving a
   per-file override surface for future policy expansion

## Fixture

`fixtures/diagnostics/slice-970-kettle-jem-ruby-method-move-policy-override/kettle-jem-ruby-method-move-policy-override.json`
