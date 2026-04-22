# Slice 305: Review Replay Bundle Reviewed Nested Executions

## Goal

Allow replay bundles to carry reviewed nested execution payloads alongside
replay decisions and replay context.

## Scope

- add optional `reviewed_nested_executions` to replay bundles
- preserve replay context and decisions unchanged
- keep reviewed nested execution payloads transport-neutral

## Contract

This slice defines one replay-bundle extension contract:

1. a replay bundle MAY contain `reviewed_nested_executions`
2. when present, reviewed nested execution payloads are replay inputs, not UI
   instructions
3. bundle semantics remain equivalent to replaying the same context, decisions,
   and reviewed nested executions together

## Shared Fixture

- `review-replay-bundle-reviewed-nested-executions.json`
