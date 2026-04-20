## Slice 83: Review Action Payload Requirements

Expose payload requirements on structured review action offers.

Goals:
- let hosts see which actions require structured input
- keep payload requirements explicit at the request surface
- avoid out-of-band action metadata

This slice defines one narrow contract:

1. review action offers may expose `requires_context`
2. `accept_default_context` does not require additional payload
3. `provide_explicit_context` requires structured context payload

Fixture:
- `family-context-review-proposal.json`
