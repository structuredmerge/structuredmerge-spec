# Slice 262: Ruby Nested In Canonical Widened Suite

## Goal

Promote `ruby_nested_portable` into the canonical widened suite set.

## Contract

This slice defines one canonical widened-suite promotion contract:

1. the widened canonical manifest MAY expose `ruby_nested_portable`
2. `ruby_nested_portable` uses the current nested Ruby roles `analysis`,
   `matching`, `discovered_surfaces`, `delegated_child_operations`,
   `delegated_child_review_transport`, `delegated_child_review_state`, and
   `delegated_child_apply_plan`
3. canonical widened planning and reporting MAY expose `ruby_nested_portable`
   as a distinct suite alongside `ruby_portable`
4. canonical widened review, reviewed-default, and replay SHOULD reuse the
   existing `family_context:ruby` request and decision surface rather than
   introducing a second defaultable Ruby family-context request

## Notes

- This slice keeps base Ruby and nested Ruby suite membership distinct.
- It extends canonical widened Ruby coverage without adding a new canonical
  family-context identity.
