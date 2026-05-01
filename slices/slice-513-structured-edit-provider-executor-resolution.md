# Slice 513: Structured Edit Provider Executor Resolution

## Goal

Standardize a portable executor-resolution record that binds one executor
selection policy to one selected executor profile from a shared registry.

## Shared Behavior

This slice defines one shared executor-resolution contract:

1. the resolution carries one executor registry,
2. the resolution carries one executor selection policy,
3. the resolution carries one selected executor profile compatible with the
   shared single executor-profile contract,
4. metadata may remain visible without changing the selected portable executor
   capability.

## Notes

- This slice standardizes resolution output, not execution dispatch.
