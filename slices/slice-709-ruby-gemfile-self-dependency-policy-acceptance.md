# Slice 709: Ruby Gemfile Self-Dependency Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting active Gemfile
dependency declarations that would make a gem depend on itself.

## Shared Behavior

This slice covers single-file self-dependency cleanup for Gemfile-like Ruby
source:

1. package identity is supplied by wrapper-provided `facts`,
2. active `gem` calls whose first argument matches the supplied gem name are
   deleted across top-level and nested Ruby contexts,
3. commented dependency examples and unrelated dependency declarations are
   preserved,
4. native policy execution fails closed with `configuration_error` when package
   identity is missing,
5. package identity derivation remains a wrapper responsibility.

## Notes

- This slice uses canonical `delete` semantics. It does not introduce a
  `remove` operation alias.
- Native tools own deterministic deletion once a wrapper supplies package
  identity; wrappers own discovery of that identity.
