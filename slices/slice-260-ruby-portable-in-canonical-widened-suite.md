# Slice 260: Ruby Portable In Canonical Widened Suite

## Goal

Promote `ruby_portable` into the canonical widened suite set.

## Contract

This slice defines one canonical widened-suite promotion contract:

1. the widened canonical manifest MAY expose `ruby_portable`
2. `ruby_portable` uses the current Ruby family roles `analysis`, `matching`,
   `discovered_surfaces`, and `delegated_child_operations`
3. canonical widened planning, reporting, review, reviewed-default, and replay
   MAY treat `ruby_portable` as another source-family suite entry
4. nested delegated Ruby review-state, reviewed-default, replay, and apply-plan
   roles remain outside canonical widened membership until a later promotion
   slice adds them explicitly

## Notes

- This slice promotes the existing base Ruby portable surface first.
- It follows the same ordering rule used for other family promotions: canonical
  family membership before nested-suite widening.
