## Slice 324: Review Replay Bundle Envelope Reviewed Nested Manifest Application

Review the current conformance manifest from a replay-bundle transport envelope
and then execute the reviewed nested work carried through the resulting review
state.

Goals:
- combine replay-bundle envelope review with reviewed nested execution in one
  shared `ast-merge` entrypoint
- preserve the review-state behavior from slice 317
- preserve the reviewed nested execution behavior from slice 320

This slice defines one contract:

1. a valid `review_replay_bundle` envelope may drive current-manifest review
2. the resulting review state matches the shared review contract
3. reviewed nested executions carried by that state are executed in order

Fixture:
- `review-replay-bundle-envelope-reviewed-nested-manifest-application.json`
