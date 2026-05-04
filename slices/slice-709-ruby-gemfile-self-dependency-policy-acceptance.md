# Slice 709: Ruby Gemfile Self-Dependency Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting active Gemfile-like
`gem` declarations that would make a project depend on itself.

## Shared Behavior

This slice covers single-file self-dependency cleanup for Ruby Gemfile-like
files:

1. project identity is supplied by wrapper-provided `project_facts`,
2. active `gem` calls whose first argument matches the supplied gem name are
   deleted,
3. matching calls are found at top level and inside nested group, platform, and
   conditional bodies,
4. multiline matching declarations are deleted as a single structural unit,
5. commented examples and unrelated gem declarations are preserved,
6. native policy execution fails closed with `configuration_error` when project
   identity is missing.

## Notes

- This slice uses canonical `delete` semantics. It does not introduce a
  `remove` operation alias.
- Wrapper orchestration still decides which Gemfile-like paths receive this
  policy.
