# Slice 58: Explicit Family Context Mode

## Goal

Require explicit family contexts when the caller opts into strict context
declaration.

## Scope

- make permissive mode the default
- allow strict mode to reject assumed defaults
- keep the strictness surface narrow and obvious

## Contract

This slice defines one small explicit-context contract:

1. aggregate planning defaults to permissive context resolution
2. in permissive mode, a missing explicit context may use a default family
   context when one is available
3. in explicit mode, a missing explicit context is a configuration error even
   when a default family context could be synthesized

## Shared Fixture

- `explicit-family-context-mode.json`
