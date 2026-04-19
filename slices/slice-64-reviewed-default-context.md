# Slice 64: Reviewed Default Context Replay

## Goal

Prove the first end-to-end export/import review loop by replaying one accepted
default-context decision into a recomputed conformance review state.

## Scope

- apply one imported review decision
- preserve replay-safe request identity
- keep the resulting context synthesis observable through diagnostics

## Contract

This slice defines one replay contract:

1. a saved `accept_default_context` decision may satisfy a matching pending
   `family_context` request
2. when applied, the producer emits the same synthesized default context it
   would have used in permissive mode
3. the applied decision is exposed in `applied_decisions`
4. the resulting state has no remaining request for that family

## Shared Fixture

- `reviewed-default-context.json`
