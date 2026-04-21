# Slice 166: Canonical Widened-Suite Replay Application

## Goal

Replay a bundled review decision against the widened canonical review state.

## Shared Behavior

This slice defines one canonical widened-suite replay-application contract:

1. the widened canonical review surface MAY accept a replay bundle,
2. the replay bundle MAY apply the same reviewed-default decision as an inline
   review interaction,
3. the resulting reviewed state remains identical to the equivalent inline
   reviewed-default state,
4. replay does not implicitly add family-local nested Markdown or Ruby
   delegated suites to the canonical surface.
