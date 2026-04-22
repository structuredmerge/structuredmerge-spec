# Slice 308: Review State Reviewed Nested Execution Application

## Goal

Execute reviewed nested execution payloads directly from review state.

## Scope

- consume `reviewed_nested_executions` from one conformance review state
- execute reviewed nested executions in review-state order
- preserve the source execution attached to each execution result

## Contract

This slice defines one shared review-state application contract:

1. `ast-merge` MUST provide a shared helper that consumes reviewed nested
   execution payloads from review state
2. the helper MUST execute reviewed nested execution payloads in review-state
   order
3. the helper MUST return one ordered result for each reviewed nested execution
4. each ordered result MUST preserve the source reviewed nested execution
   payload alongside its merge result

## Shared Fixture

- `review-state-reviewed-nested-execution-application.json`
