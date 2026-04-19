# Slice 68: Stale Review Decision Rejection

## Goal

Reject replay decisions whose request ids no longer correspond to a live
reviewable request while still applying compatible live decisions.

## Scope

- preserve valid replay decisions
- reject stale request ids explicitly
- avoid all-or-nothing failure when only some replay inputs are stale

## Contract

This slice defines one stale-decision contract:

1. replay decisions are filtered against the current set of live review request
   ids
2. matching replay decisions may still apply
3. non-matching replay decisions emit explicit replay-rejection diagnostics
4. stale decisions are not included in `applied_decisions`

## Shared Fixture

- `stale-review-decision.json`
