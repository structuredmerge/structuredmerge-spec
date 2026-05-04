# Slice 691: Markdown Markly Request Projection Target Semantics

## Goal

Correct the Markdown Markly structured edit request projection so it projects
the heading-section replace parity shape with first-class target semantics.

## Shared Behavior

This slice updates the Markdown Markly request projection surface:

1. the projected request uses a section-branch target selector,
2. the projected request carries `target_selection` for heading-section
   selection semantics,
3. the projected request carries `target_match` for section-branch boundary and
   payload semantics,
4. result, application, and execution-report projections stay coherent with the
   replace request.

## Notes

- This removes the old insertion/destination projection from the primary
  Markly request projection path rather than treating Markly as a carveout.
