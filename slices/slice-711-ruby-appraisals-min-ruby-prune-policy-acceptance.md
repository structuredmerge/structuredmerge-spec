# Slice 711: Ruby Appraisals Min-Ruby Prune Policy Acceptance

## Goal

Define provider-neutral native policy behavior for deleting Appraisals entries
whose Ruby-version appraisal is below a supplied minimum Ruby version.

## Shared Behavior

This slice covers deterministic Appraisals pruning:

1. `min_ruby` is supplied by wrapper-provided runtime context,
2. appraisal blocks whose names encode Ruby versions below `min_ruby` are
   deleted,
3. non-Ruby-version appraisals and Ruby-version appraisals at or above
   `min_ruby` are preserved,
4. native policy execution fails closed with `configuration_error` when
   `min_ruby` is missing,
5. minimum Ruby discovery remains a wrapper responsibility.

## Notes

- This slice uses canonical `delete` semantics.
- Native tools own version comparison and deterministic deletion after the
  wrapper supplies `min_ruby`.
