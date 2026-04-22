## Slice 320: Review Replay Bundle Envelope Reviewed Nested Execution Application

Execute reviewed nested work directly from a `review_replay_bundle` transport
envelope.

Goals:
- make replay-bundle transport artifacts directly executable at the shared
  `ast-merge` layer
- preserve the existing reviewed nested execution behavior from slice 307
- keep transport import separate from family-specific orchestration

This slice defines one contract:

1. a valid `review_replay_bundle` envelope may be imported and executed
2. the resulting reviewed nested execution runs match the equivalent direct
   replay-bundle execution

Fixture:
- `review-replay-bundle-envelope-reviewed-nested-execution-application.json`
