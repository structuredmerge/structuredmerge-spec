# Slice 255: Family Nested Suites Outside Canonical Flow

## Goal

Keep nested or delegated family suites family-scoped until their review,
default, and replay policy can be expressed as a parser-agnostic canonical
contract.

## Contract

1. a family MAY define nested or delegated named suites over shared
   review-state, replay, and apply-plan shapes without promoting those suites
   into the canonical stable or widened suite sets
2. the existence of shared delegated-child transport, review-state, or
   apply-plan helpers MUST NOT by itself make a nested family suite part of the
   canonical review, reviewed-default, or replay surfaces
3. canonical suite growth SHOULD require a later slice that defines the
   canonical family membership and any new defaulting or review policy needed
   for the promoted suite
4. until such a slice exists, nested Markdown delegated suites SHOULD remain in
   their dedicated family manifests or named suites even when their underlying
   operation shapes are fully portable
5. family-scoped nested suites MAY still be planned, reported, reviewed, and
   replayed through the ordinary named-suite machinery when explicitly selected

## Notes

- This slice separates portable shape reuse from canonical policy promotion.
- It keeps canonical review state from becoming noisy or ambiguous before suite
  membership and defaulting rules are shared explicitly.
