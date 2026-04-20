## Slice 84: Review Action Payload Kind

Expose a stable payload-kind hint on review action offers that require
structured input.

Goals:
- let hosts identify payload shape without guessing from the action name
- keep the action surface compact
- avoid out-of-band payload contracts

This slice defines one narrow contract:

1. action offers may expose `payload_kind`
2. `provide_explicit_context` exposes payload kind `conformance_family_context`
3. actions that do not require payload omit `payload_kind`

Fixture:
- `family-context-review-proposal.json`
