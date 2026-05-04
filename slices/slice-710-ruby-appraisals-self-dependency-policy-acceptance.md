# Slice 710: Ruby Appraisals Self-Dependency Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting active Appraisals
`gem` declarations that would make a project depend on itself.

## Shared Behavior

This slice covers single-file self-dependency cleanup for Ruby Appraisals files:

1. project identity is supplied by wrapper-provided `project_facts`,
2. active `gem` calls inside `appraise` block bodies whose first argument
   matches the supplied gem name are deleted,
3. multiple appraise blocks and multiple matching declarations in one block are
   handled,
4. appraisal comments, appraisal block structure, and unrelated gem
   declarations are preserved,
5. native policy execution fails closed with `configuration_error` when project
   identity is missing.

## Notes

- This slice uses canonical `delete` semantics. It does not introduce a
  `remove` operation alias.
- Wrapper orchestration still decides which Appraisals-like paths receive this
  policy.
