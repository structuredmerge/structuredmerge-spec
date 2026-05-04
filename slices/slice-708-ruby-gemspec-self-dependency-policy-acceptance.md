# Slice 708: Ruby Gemspec Self-Dependency Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting active gemspec
dependency declarations that would make a gem depend on itself.

## Shared Behavior

This slice covers single-file self-dependency cleanup for Ruby gemspecs:

1. project identity is supplied by wrapper-provided `project_facts`,
2. active `spec.add_dependency`, `spec.add_runtime_dependency`, and
   `spec.add_development_dependency` calls whose first argument matches the
   supplied gem name are deleted,
3. commented dependency examples and unrelated dependency declarations are
   preserved,
4. native policy execution fails closed with `configuration_error` when project
   identity is missing,
5. project identity derivation remains a wrapper responsibility.

## Notes

- This slice uses canonical `delete` semantics. It does not introduce a
  `remove` operation alias.
- The policy is deterministic once the wrapper supplies project identity.
