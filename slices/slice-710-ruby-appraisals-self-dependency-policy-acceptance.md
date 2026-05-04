# Slice 710: Ruby Appraisals Self-Dependency Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting active Appraisals
dependency declarations that would make a gem depend on itself.

## Shared Behavior

This slice covers single-file self-dependency cleanup for Ruby Appraisals files:

1. package identity is supplied by wrapper-provided `facts`,
2. active `gem` calls inside `appraise` blocks whose first argument matches the
   supplied gem name are deleted,
3. unrelated appraisal blocks, unrelated dependencies, and comments are
   preserved,
4. native policy execution fails closed with `configuration_error` when package
   identity is missing,
5. package identity derivation remains a wrapper responsibility.

## Notes

- This slice uses canonical `delete` semantics.
- Appraisals file discovery and package identity derivation remain wrapper
  responsibilities.
