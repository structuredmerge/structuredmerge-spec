## Slice 80: Explicit Review Decision Payload Validation

Reject explicit family-context review decisions that omit the required
structured context payload.

Goals:
- keep explicit override decisions self-validating
- reject malformed payloads visibly
- leave the underlying request open for later valid review

This slice defines one narrow contract:

1. `provide_explicit_context` requires a `context` payload
2. a missing payload emits an explicit error
3. malformed explicit decisions do not resolve the family context
4. the original review request remains available

Fixture:
- `explicit-review-decision-missing-context.json`
