# Slice 306: Review State Reviewed Nested Executions

## Goal

Emit replayed reviewed nested execution payloads through conformance review
state so they can be carried forward through the review/apply pipeline.

## Scope

- apply a valid replay bundle that contains reviewed nested execution payloads
- preserve current replay-safety behavior
- emit reviewed nested execution payloads unchanged in the resulting review
  state

## Contract

This slice defines one review-state extension contract:

1. a valid replay bundle MAY include reviewed nested execution payloads
2. when replay is accepted, emitted review state MUST include the same
   `reviewed_nested_executions`
3. replay rejection behavior for context and stale decisions remains unchanged

## Shared Fixture

- `review-state-reviewed-nested-executions.json`
