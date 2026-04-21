# Slice 258: Base Family Before Nested Promotion

## Goal

Require canonical promotion of a family's ordinary portable suite before any
family-scoped nested or delegated suite for that family may be promoted.

## Contract

1. a family-scoped nested or delegated suite SHOULD NOT be promoted into the
   canonical stable or widened suite sets before that family's ordinary
   portable suite is itself a canonical member of the target set
2. when a family has no existing canonical review/default/replay identity
   surface, a promotion slice SHOULD first establish that ordinary family
   surface before attempting nested canonical promotion
3. Markdown nested therefore remains blocked on canonical promotion of
   `markdown_portable`
4. once a family's ordinary portable suite is canonical, any nested promotion
   for that family remains subject to the separate identity/default/replay
   gate defined by later slices

## Notes

- This slice reduces ambiguity by preventing nested suites from becoming the
  first canonical identity surface for a family.
- It makes nested promotion an extension of an existing canonical family
  surface rather than a leapfrog promotion.
