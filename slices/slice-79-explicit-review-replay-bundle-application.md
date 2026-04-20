## Slice 79: Explicit Review Replay Bundle Application

Apply one explicit family-context review decision through a replay bundle.

Goals:
- prove payload-carrying review decisions survive replay transport
- keep replay rejection and request-id filtering unchanged
- show that explicit context payloads are applied end-to-end

This slice defines one narrow contract:

1. a replay bundle may carry `provide_explicit_context` with one structured
   `context`
2. when replay compatibility is satisfied, that explicit context is applied
3. existing replay rejection rules remain unchanged

Fixture:
- `explicit-review-replay-bundle-application.json`
