## Slice 325: Review Replay Bundle Envelope Reviewed Nested Manifest Rejection

Reject replay-bundle transport envelopes for manifest-driven reviewed nested
application while still producing current manifest review state.

Goals:
- preserve the fallback review behavior from slice 319
- produce no reviewed nested execution runs when envelope import fails
- keep transport rejection localized to the replay-bundle envelope boundary

This slice defines one rejection contract:

1. invalid replay-bundle envelopes still produce current manifest review state
2. the resulting state carries the transport diagnostic from envelope import
3. no reviewed nested executions run after replay-bundle envelope rejection

Fixture:
- `review-replay-bundle-envelope-reviewed-nested-manifest-rejection.json`
