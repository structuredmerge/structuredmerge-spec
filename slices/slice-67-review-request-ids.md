# Slice 67: Review Request Ids

## Goal

Expose the normalized stable review-request identities that are currently
available for replay.

## Scope

- derive request ids from the current manifest and review options
- keep the surface deterministic and transport-agnostic
- focus on request identity, not UI text

## Contract

This slice defines one request-identity contract:

1. stable request ids are derived from the current unresolved review surface
2. only request ids that are currently reviewable are exposed
3. request-id enumeration is deterministic

## Shared Fixture

- `review-request-ids.json`
