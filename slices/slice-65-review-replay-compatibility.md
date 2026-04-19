# Slice 65: Review Replay Compatibility

## Goal

Define a small normalized compatibility check for imported review state.

## Scope

- compare replay context to the current manifest replay context
- keep the comparison explicit and deterministic
- avoid best-effort rebinding of imported review decisions

## Contract

This slice defines one replay-compatibility contract:

1. imported review decisions are replay-safe only when their replay context
   matches the current replay context
2. compatibility is evaluated on the normalized replay-context surface, not on
   runtime-local ordering alone
3. absent replay context is not compatible

## Shared Fixture

- `review-replay-compatibility.json`
