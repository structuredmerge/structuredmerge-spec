# Slice 70: Review Replay Bundle Application

## Goal

Apply a replay bundle through the existing review-state seam without changing
observable replay-safety behavior.

## Scope

- prove that a valid replay bundle applies decisions
- keep replay rejection and stale-decision filtering unchanged
- preserve the current emitted replay context

## Contract

This slice defines one replay-bundle application contract:

1. a valid replay bundle may satisfy matching live review requests
2. applying the bundle produces the same observable state as equivalent legacy
   replay inputs
3. replay-safety and stale-decision rejection rules still apply

## Shared Fixture

- `review-replay-bundle-application.json`
