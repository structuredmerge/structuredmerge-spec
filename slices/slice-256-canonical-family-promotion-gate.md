# Slice 256: Canonical Family Promotion Gate

## Goal

Define the minimum evidence required before a family-scoped suite may be
promoted into the canonical stable or widened suite sets.

## Contract

1. canonical family promotion SHOULD remain a separate decision from canonical
   manifest widening and from shared-shape portability
2. a later promotion slice SHOULD identify the exact family or suite
   descriptor being promoted and the canonical suite set into which it is
   promoted
3. before a family-scoped nested or delegated suite is promoted, the promoting
   slice SHOULD show that its review-state, reviewed-default, and replay
   behavior can be described without parser-specific ambiguity in canonical
   terms
4. before such a promotion, the promoting slice SHOULD define how canonical
   review requests, default decisions, and replay bundles identify the promoted
   suite without colliding with existing canonical family membership
5. before such a promotion, the promoting slice SHOULD define whether the new
   canonical member introduces a new defaultable family context or reuses an
   existing family context surface
6. a family-scoped suite MUST NOT be treated as canonical merely because its
   underlying delegated-child, review, or apply-plan shapes are portable

## Notes

- This slice defines a promotion gate, not a rejection of future canonical
  growth.
- It keeps canonical growth tied to shared policy clarity instead of transport
  reuse alone.
