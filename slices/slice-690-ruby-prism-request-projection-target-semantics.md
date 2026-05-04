# Slice 690: Ruby Prism Request Projection Target Semantics

## Goal

Project first-class target selection and match semantics through the Ruby Prism
structured edit request projection.

## Shared Behavior

This slice updates the Ruby Prism request projection surface:

1. the projected request keeps its existing comment-anchor selector,
2. the projected request carries `target_selection` for comment-owned owner
   selection semantics,
3. the projected request carries `target_match` for comment-owned body and
   trailing-gap boundary semantics,
4. application and execution-report projections that embed the request preserve
   the same first-class descriptors.

## Notes

- This is the first provider adoption step after slices 687 and 688.
