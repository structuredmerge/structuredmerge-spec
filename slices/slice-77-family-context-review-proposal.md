## Slice 77: Family-Context Review Proposal

Expose the synthesized default family context as structured request data.

Goals:
- keep review requests host-neutral
- expose the proposed default context as structured data
- avoid forcing hosts to parse the review message string

This slice defines one narrow contract:

1. a `family_context` review request may carry `proposed_context`
2. the proposed context is the same synthesized default context that would be
   applied by `accept_default_context`
3. the proposal is structured data, not prose-only explanation

Fixture:
- `family-context-review-proposal.json`
