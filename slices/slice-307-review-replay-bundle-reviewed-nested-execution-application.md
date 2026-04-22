# Slice 307: Review Replay Bundle Reviewed Nested Execution Application

## Goal

Execute reviewed nested execution payloads directly from replay bundles.

## Scope

- consume `reviewed_nested_executions` from one replay bundle
- execute reviewed nested executions in bundle order
- preserve the source execution attached to each execution result

## Contract

This slice defines one shared replay-application contract:

1. `ast-merge` MUST provide a shared helper that consumes reviewed nested
   execution payloads from a replay bundle
2. the helper MUST execute reviewed nested execution payloads in bundle order
3. the helper MUST return one ordered result for each reviewed nested execution
4. each ordered result MUST preserve the source reviewed nested execution
   payload alongside its merge result

## Shared Fixture

- `review-replay-bundle-reviewed-nested-execution-application.json`
