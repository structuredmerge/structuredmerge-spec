## Slice 78: Family-Context Explicit Review Decision

Allow a review decision to carry one explicit family context through the
existing review seam.

Goals:
- keep explicit context selection inside the replay-safe review surface
- avoid a separate out-of-band override channel
- preserve `accept_default_context` as the defaultable short path

This slice defines one narrow contract:

1. `provide_explicit_context` is a valid `family_context` review action
2. that action carries one structured `context` payload
3. when accepted, the emitted family context is the provided explicit context
   rather than the synthesized default

Fixture:
- `family-context-explicit-review-decision.json`
