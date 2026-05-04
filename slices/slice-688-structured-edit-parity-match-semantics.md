# Slice 688: Structured Edit Parity Match Semantics

## Goal

Standardize first-class family-level match semantics needed by CRISPR parity
scenarios.

## Shared Behavior

This slice defines one shared parity-match semantics surface:

1. a structured edit request may carry a portable target-match descriptor,
2. the descriptor may state family-level start and end boundary intent,
3. the descriptor may capture comment-owned and section-branch payload
   semantics without binding to a single parser backend,
4. the descriptor is optional and does not change existing request shape when
   absent,
5. the descriptor is meant to reduce reliance on metadata-only parity notes.

## Notes

- This slice pairs with slice 687 to finish the main parity-substrate cleanup.
