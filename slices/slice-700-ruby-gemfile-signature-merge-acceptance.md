# Slice 700: Ruby Gemfile Signature Merge Acceptance

## Goal

Define provider-neutral acceptance behavior for Gemfile-like Ruby source merges
that kettle-jem currently handles through Prism-specific signature callbacks and
runtime policies.

## Shared Behavior

This slice defines a Ruby-source `smart_merge` recipe profile for Gemfile-like
files:

1. `source` and `ruby` declarations are singleton signatures,
2. `git_source` declarations match by source name,
3. `gem` declarations match by gem name within declaration context,
4. `group` declarations match by group argument set,
5. `eval_gemfile` declarations match by normalized path,
6. template-only declarations are added,
7. matched declarations use template content when the profile says
   `preference: template`,
8. destination-only declarations and attached spacing/comment shape are
   preserved where the destination wins,
9. cross-nesting duplicate gem declarations fail closed instead of producing a
   corrupt Gemfile.

## Notes

- The fixture references `provider_family: ruby_source` and a generic
  `signature_profile: gemfile_declarations`. It does not require every language
  implementation to expose Prism.
- This is a whole-document merge acceptance surface. CRISPR remains available as
  a later recipe step, but it is not the right primitive for signature-driven
  multi-node alignment.
