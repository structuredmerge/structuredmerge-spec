# Slice 263: Markdown Canonical Provider Gate

## Goal

Define the remaining blocker before the base portable descriptor for grammar
`markdown` can be promoted into a canonical suite set.

## Contract

1. the base portable descriptor for grammar `markdown` SHOULD NOT be promoted
   into a canonical suite set until a later slice chooses the canonical
   provider or provider-selection rule for Markdown family contexts
2. that later slice SHOULD define whether canonical Markdown review/default/
   replay uses one native provider identity, one substrate identity, or an
   explicit provider-selection rule that remains portable across hosts
3. nested Markdown promotion remains blocked on both this base-family provider
   gate and the ordinary nested-suite promotion gate

## Notes

- Markdown already has a portable family contract.
- The remaining blocker is canonical provider policy, not shared-shape
  transport.
