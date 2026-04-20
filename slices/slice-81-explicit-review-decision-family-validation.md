## Slice 81: Explicit Review Decision Family Validation

Reject explicit family-context review decisions whose payload targets the wrong
family.

Goals:
- prevent cross-family rebinding by payload
- keep the review seam strongly typed at the family boundary
- preserve the original review request when validation fails

This slice defines one narrow contract:

1. `provide_explicit_context` payload family must match the review request
2. mismatched family payload emits an explicit error
3. mismatched payload does not resolve the family context
4. the original review request remains available

Fixture:
- `explicit-review-decision-family-mismatch.json`
