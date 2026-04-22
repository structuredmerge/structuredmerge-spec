## Slice 318: Explicit Review Replay Bundle Envelope Application

Apply one explicit family-context review decision through a replay-bundle
transport envelope.

Goals:
- prove structured explicit-context decisions survive replay-bundle envelope
  transport
- keep replay compatibility and request-id filtering unchanged
- show explicit context is applied end-to-end after import

This slice defines one narrow contract:

1. a `review_replay_bundle` envelope may carry `provide_explicit_context` with
   one structured `context`
2. when replay compatibility is satisfied, that explicit context is applied
3. existing replay rejection rules remain unchanged

Fixture:
- `explicit-review-replay-bundle-envelope-application.json`
