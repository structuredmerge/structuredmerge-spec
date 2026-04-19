# Slice 66: Review Replay Rejection

## Goal

Reject stale or misbound imported review decisions visibly instead of silently
reattaching them.

## Scope

- define one observable replay-rejection diagnostic
- keep unresolved requests open when replay is rejected
- preserve the current replay context in the emitted state

## Contract

This slice defines one replay-rejection contract:

1. incompatible imported review decisions are not applied
2. replay rejection emits an explicit diagnostic
3. rejected replay does not remove the pending review request
4. the producer still emits the current replay context for a later valid retry

## Shared Fixture

- `review-replay-rejection.json`
