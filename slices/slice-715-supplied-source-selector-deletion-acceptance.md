# Slice 715: Supplied Source Selector Deletion Acceptance

## Goal

Define provider-neutral native source/AST recipe behavior for deleting structural
owners from caller-supplied selectors.

## Shared Behavior

This slice covers deterministic source selector deletion:

1. delete selectors are supplied by wrapper-provided runtime context,
2. the native recipe deletes matching structural-owner ranges in stable order,
3. deletion normalizes excessive blank lines left by removed ranges,
4. unmatched source content and surrounding comments are preserved,
5. native recipe execution fails closed with `configuration_error` when selectors
   are missing or malformed,
6. Rakefile policy, require/task matching, satellite selection, similarity
   scoring, and scaffold decisions remain wrapper/plugin responsibilities.

## Notes

- This slice uses `provider_family: generic_ast` and a generic structural-owner
  backend.
- The fixture models the native substrate needed by Rakefile scaffold cleanup
  without encoding Rake or Ruby project semantics in `ast-merge`.
- The supplied selector shape is a recipe contract, not a core project model.
