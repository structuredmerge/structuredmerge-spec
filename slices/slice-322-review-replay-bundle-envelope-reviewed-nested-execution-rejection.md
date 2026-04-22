## Slice 322: Review Replay Bundle Envelope Reviewed Nested Execution Rejection

Reject replay-bundle transport envelopes whose identity does not match the
expected replay-bundle kind or version before reviewed nested execution.

Goals:
- surface replay-bundle envelope import failures as diagnostics
- produce no reviewed nested execution runs when import fails
- keep rejection behavior transport-scoped and deterministic

This slice defines one rejection contract:

1. importing replay-bundle envelope input requires kind `review_replay_bundle`
2. importing replay-bundle envelope input requires supported version `1`
3. when import fails, one transport diagnostic is returned and no executions
   run

Fixture:
- `review-replay-bundle-envelope-reviewed-nested-execution-rejection.json`
