# Slice 25: Backend Registry

## Goal

Plan a normalized registry for named parser backends.

## Planned Scope

- define a backend registry vocabulary
- normalize how backend identities are named and selected
- keep the contract separate from any one tree-sitter binding

## Shared Behavior

This slice defines one backend identity contract:

1. a backend reference has a stable `id`
2. it has a backend-family classification
3. adapter and feature-profile reporting may expose both a legacy backend string
   and a normalized backend reference during transition
4. the backend registry is descriptive rather than executable

## Shared Types

- `BackendReference`

## Notes

- This slice is planned ahead to keep adapter work from becoming ad hoc once
  backend implementations deepen.
