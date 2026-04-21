# Slice 259: Ruby Family In Canonical Manifest

## Goal

Admit the Ruby family into the canonical shared conformance manifest without
yet promoting nested delegated Ruby behavior into the canonical suite set.

## Contract

This slice defines one canonical-manifest widening contract:

1. the canonical manifest MAY include the Ruby family feature profile entry
2. it MAY include the representative Ruby roles `analysis`, `matching`,
   `discovered_surfaces`, and `delegated_child_operations`
3. this widening does not require the canonical suite set to add nested
   delegated Ruby roles immediately

## Notes

- This slice widens the canonical manifest to the current non-nested portable
  Ruby surface only.
- Nested delegated Ruby review/default/replay behavior remains family-scoped
  until a later slice promotes it explicitly.
