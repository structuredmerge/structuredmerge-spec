# Slice 132: Backend Ownership Boundary

## Goal

Clarify which backends belong in `tree-haver` and which belong in merge-family
libraries.

## Shared Behavior

This slice defines the ownership boundary:

1. `tree-haver` owns reusable parser-framework backends that can serve multiple
   grammars or families.
2. merge-family libraries own one-trick parser integrations that are specific
   to one language or one structured family.
3. both styles must still emit the same `tree-haver`-shaped contracts upward
   into family analysis, conformance, and review-state surfaces.
4. backend plurality is a family concern, but backend hosting is not required
   to be centralized in `tree-haver`.

## Examples

- `tree-sitter`, `Parslet`, `Citrus`, `pest`, `Peggy`, and `pigeon` are
  parser-framework candidates for `tree-haver`.
- `go/parser`, `syn`, TypeScript compiler APIs, `prism`, `psych`, and `rbs`
  are parser-specific candidates for merge-family-local backend realization.

## Notes

- This slice keeps `tree-haver` from drifting into a kitchen-sink adapter
  layer.
- It also makes multi-backend family validation possible without forcing every
  backend to be packaged or installed together.
