# Slice 711: Ruby Appraisals Minimum Ruby Prune Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting Ruby-version
Appraisals blocks that are below a supplied minimum Ruby version.

## Shared Behavior

This slice covers single-file Ruby-version appraisal pruning:

1. `min_ruby` is supplied by wrapper/runtime context,
2. `appraise` blocks named `ruby-X-Y` whose version is below `min_ruby` are
   deleted,
3. Ruby appraisal blocks at or above `min_ruby` are preserved,
4. non-Ruby appraisal blocks are preserved,
5. runs of excessive blank lines caused by pruning are normalized,
6. native policy execution fails closed with `configuration_error` when
   `min_ruby` is missing.

## Notes

- This slice uses canonical `delete` semantics. It does not introduce a
  `remove` operation alias.
- Wrapper orchestration still decides how `min_ruby` is derived.
