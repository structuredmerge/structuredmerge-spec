# Slice 133: Family Substrate Layer

## Goal

Recognize parser-agnostic family logic as its own reusable layer.

## Shared Behavior

This slice defines a family substrate as:

1. parser-agnostic family rules that can be shared across multiple parser
   backends for the same family,
2. normalization of family node kinds, owner paths, and merge-relevant
   structure,
3. a layer that may live inside one merge library or in a dedicated shared
   family package, depending on packaging and dependency constraints.

## Shared Consequences

- Simple families MAY keep the substrate inside one merge library.
- Complex families MAY split into:
  - one parser-agnostic substrate package, and
  - parser-specific merge packages layered on top of it.

## Notes

- Markdown-family work is the motivating example for this split.
- This slice does not require a separate substrate package for every family.
- The point is to make the seam explicit before packaging pressure forces it.
