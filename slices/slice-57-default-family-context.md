# Slice 57: Default Family Context

## Goal

Allow aggregate conformance planning to synthesize a family context from a
declared family profile when no explicit context is provided.

## Scope

- define the default family-context shape
- keep backend-specific feature profile optional
- support short configurations without silent omission

## Contract

This slice defines one small default-context contract:

1. a default family context may be synthesized from a family profile alone
2. the synthesized context contains that family profile and no feature profile
3. when a default context is assumed, the operation emits a diagnostic

## Shared Fixture

- `default-family-context.json`
