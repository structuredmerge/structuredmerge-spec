# Slice 702: Ruby Gemspec Signature Merge Acceptance

## Goal

Define provider-neutral smart-merge acceptance behavior for Ruby gemspec
declaration signatures.

## Shared Behavior

This slice covers the native smart-merge portion of gemspec support:

1. the `Gem::Specification.new` block is a singleton declaration,
2. gemspec field assignments match by field name, independent of block
   parameter name,
3. `spec.metadata[key] = value` entries match by metadata key,
4. operator writes such as `spec.rdoc_options += [...]` match by field and
   operator,
5. dependency declarations match by dependency method and gem name,
6. matched declarations use template content for `preference: template`,
7. destination-only declarations are preserved,
8. template-only declarations are added.

## Notes

- This slice intentionally stops before gemspec harmonization policies such as
  `spec.files` literal union, dependency-section relocation, and version-loader
  rewrite.
- The shared surface is `provider_family: ruby_source` plus
  `signature_profile: gemspec_declarations`, not Prism-specific callbacks.
