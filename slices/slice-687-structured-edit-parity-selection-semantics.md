# Slice 687: Structured Edit Parity Selection Semantics

## Goal

Standardize first-class family-level selection semantics needed by CRISPR
parity scenarios.

## Shared Behavior

This slice defines one shared parity-selection semantics surface:

1. a portable selection descriptor may state selector kind and family-level
   intent,
2. the descriptor may capture comment-anchored and section-branch selection
   semantics without binding to a single parser backend,
3. the descriptor is meant to reduce reliance on metadata-only parity notes.

## Notes

- This slice is the likely follow-on after callable destination support.
