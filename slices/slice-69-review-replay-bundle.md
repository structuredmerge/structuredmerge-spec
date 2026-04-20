# Slice 69: Review Replay Bundle

## Goal

Group replay decisions and replay context into one explicit handoff object.

## Scope

- define one replay-bundle shape
- keep the bundle transport-agnostic
- preserve compatibility with earlier parallel-field wiring during transition

## Contract

This slice defines one replay-bundle contract:

1. a replay bundle contains `replay_context` and `decisions`
2. the bundle is a handoff object, not a UI instruction
3. bundle semantics are equivalent to supplying the same replay context and
   decisions separately

## Shared Fixture

- `review-replay-bundle.json`
