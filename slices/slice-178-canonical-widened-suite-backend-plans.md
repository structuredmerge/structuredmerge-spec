# Slice 178: Canonical Widened-Suite Backend Plans

## Goal

Plan the canonical widened suite set through alternate TOML and YAML backends
while preserving the existing backend-sensitive source-family contexts.

## Shared Behavior

This slice defines one language-local widened planning contract:

1. the canonical widened suite surface remains unchanged,
2. alternate TOML and YAML backends propagate through the widened canonical
   plan,
3. source-family backend requirements remain unchanged in the same plan.
