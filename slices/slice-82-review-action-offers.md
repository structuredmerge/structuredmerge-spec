## Slice 82: Review Action Offers

Replace bare review-action strings with structured action offers.

Goals:
- make request actions self-describing
- keep host behavior transport-safe and UI-neutral
- preserve the same action vocabulary

This slice defines one narrow contract:

1. review requests expose `action_offers` instead of `available_actions`
2. each action offer names one `action`
3. the baseline family-context request exposes two offers:
   `accept_default_context` and `provide_explicit_context`

Fixture:
- `family-context-review-request.json`
