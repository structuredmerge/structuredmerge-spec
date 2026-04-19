# Slice 17: Policy Vocabulary

## Goal

Introduce a shared cross-format vocabulary for exposed merge policies.

## Planned Scope

- a neutral policy surface vocabulary
- a minimal policy reference shape
- seed policy names for the already-validated fallback and array behaviors

## Shared Behavior

This slice defines a portable descriptive contract:

1. exposed policies are identified by `surface` and `name`
2. policy surfaces are shared vocabulary, not format-local prose
3. policy names are stable comparison values for conformance fixtures
4. this slice describes exposed policy identity, not policy execution

## Shared Types

- `PolicySurface`
- `PolicyReference`

## Notes

- This slice does not require every merge result to expose policy references
  yet.
- It creates the shared vocabulary needed before richer policy negotiation or
  reporting is added.
