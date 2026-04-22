## Slice 323: Review State Envelope Reviewed Nested Execution Rejection

Reject review-state transport envelopes whose identity does not match the
expected review-state kind or version before reviewed nested execution.

Goals:
- surface review-state envelope import failures as diagnostics
- produce no reviewed nested execution runs when import fails
- keep rejection behavior transport-scoped and deterministic

This slice defines one rejection contract:

1. importing review-state envelope input requires kind
   `conformance_manifest_review_state`
2. importing review-state envelope input requires supported version `1`
3. when import fails, one transport diagnostic is returned and no executions
   run

Fixture:
- `review-state-envelope-reviewed-nested-execution-rejection.json`
