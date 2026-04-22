## Slice 317: Review Replay Bundle Envelope Application

Apply a replay bundle transport envelope through the existing manifest review
pipeline.

Goals:
- prove that one valid replay-bundle envelope imports and applies decisions
- keep replay compatibility, stale-decision filtering, and reviewed nested
  execution behavior unchanged
- preserve the same observable review state as the equivalent direct replay
  bundle input

This slice defines one replay-bundle envelope contract:

1. a valid `review_replay_bundle` envelope may be imported and applied through
   conformance-manifest review
2. the resulting review state matches the equivalent direct replay-bundle
   application
3. existing replay-safety behavior remains unchanged

Fixture:
- `review-replay-bundle-envelope-application.json`
