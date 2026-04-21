# Slice 262: Ruby Nested In Canonical Widened Suite

## Goal

Promote the nested portable Ruby suite descriptor into the canonical widened
suite set.

## Contract

This slice defines one canonical widened-suite promotion contract:

1. the widened canonical manifest MAY expose the nested portable Ruby suite
   descriptor
2. that nested Ruby descriptor uses the current nested Ruby roles `analysis`,
   `matching`, `discovered_surfaces`, `delegated_child_operations`,
   `delegated_child_review_transport`, `delegated_child_review_state`, and
   `delegated_child_apply_plan`
3. canonical widened planning and reporting MAY expose that nested Ruby
   descriptor as a distinct suite alongside the base portable Ruby descriptor
4. canonical widened review, reviewed-default, and replay SHOULD reuse the
   existing `family_context:ruby` request and decision surface rather than
   introducing a second defaultable Ruby family-context request

## Notes

- This slice keeps base Ruby and nested Ruby suite membership distinct.
- It extends canonical widened Ruby coverage without adding a new canonical
  family-context identity.
