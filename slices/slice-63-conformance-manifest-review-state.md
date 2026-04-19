# Slice 63: Conformance Manifest Review State

## Goal

Wrap aggregate conformance reporting in a resumable review-state envelope that
can be externalized or handled inline.

## Scope

- preserve the existing aggregate named-suite report
- add requests, applied decisions, host hints, and replay context
- keep diagnostics visible alongside the report

## Contract

This slice defines one conformance review-state contract:

1. review state contains `report`, `diagnostics`, `requests`,
   `applied_decisions`, `host_hints`, and `replay_context`
2. `report` remains the existing named-suite report envelope
3. `requests` records unresolved reviewable items
4. `replay_context` carries enough normalized context to avoid blind replay by
   local ordinal alone

## Shared Fixture

- `conformance-manifest-review-state.json`
