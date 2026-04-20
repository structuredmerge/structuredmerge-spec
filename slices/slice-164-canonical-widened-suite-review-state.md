# Slice 164: Canonical Widened-Suite Review State

## Goal

Review the widened canonical manifest through a mixed explicit-and-requested
context surface.

## Shared Behavior

This slice defines one canonical widened-suite review-state contract:

1. explicit contexts MAY cover only a subset of the widened canonical families,
2. remaining canonical source-family contexts become review requests rather than
   silent omissions,
3. already-resolved canonical families continue to report results while review
   requests remain open.
