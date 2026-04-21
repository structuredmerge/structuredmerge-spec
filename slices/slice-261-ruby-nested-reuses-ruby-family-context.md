# Slice 261: Ruby Nested Reuses Ruby Family Context

## Goal

Define the recommended canonical review/default/replay attachment point for a
future nested Ruby suite promotion.

## Contract

1. if a nested delegated Ruby suite is later promoted into the canonical
   widened suite set, it SHOULD remain a distinct named suite rather than
   silently widening `ruby_portable`
2. that promoted nested Ruby suite SHOULD reuse the existing
   `family_context:ruby` review-request, reviewed-default, and replay identity
   surface
3. a later nested Ruby promotion slice SHOULD therefore add canonical suite
   membership and execution coverage without introducing a second defaultable
   Ruby family-context request

## Notes

- This keeps base Ruby and nested Ruby suite membership distinct.
- It avoids introducing a new canonical default surface when the existing Ruby
  family context can already carry the needed meaning.
