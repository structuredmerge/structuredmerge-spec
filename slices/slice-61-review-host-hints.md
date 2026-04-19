# Slice 61: Review Host Hints

## Goal

Expose a small, transport-agnostic hint surface describing how a producer was
asked to behave when reviewable state is emitted.

## Scope

- define one normalized host-hints object
- keep it descriptive rather than imperative
- avoid embedding prompting or transport behavior in the core contract

## Contract

This slice defines one small host-hints contract:

1. review state may expose `host_hints`
2. `host_hints` records whether the producing call was interactive-capable
3. `host_hints` records whether explicit family contexts were required

## Shared Fixture

- `review-host-hints.json`
