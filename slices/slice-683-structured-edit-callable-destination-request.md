# Slice 683: Structured Edit Callable Destination Request

## Goal

Standardize a first-class callable destination descriptor on the shared
structured edit request surface.

## Shared Behavior

This slice defines one shared callable-destination request surface:

1. a structured edit request may carry a callable destination descriptor,
2. the descriptor identifies the destination anchor intent without relying on
   parser-specific executable code,
3. the descriptor may coexist with a normal source selector and replacement
   payload,
4. the descriptor is optional and does not change the existing request shape
   when absent.

## Notes

- This slice addresses the main substrate gap surfaced by the CRISPR parity
  report: callable destination semantics should not live only in metadata.
