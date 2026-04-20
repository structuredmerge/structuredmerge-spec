# Slice 240: Delegated Child Group Review State

`ast-merge` MUST provide a delegated child group review-state helper.

Given:

- apply-ready projected child review groups,
- a family identifier, and
- replayed review decisions,

the helper MUST return:

- outstanding delegated child review requests,
- accepted delegated child groups,
- applied delegated child review decisions, and
- replay rejection diagnostics for stale or unrelated delegated-child decisions.

This helper extends the shared review transport with a delegated-child review
cycle that parallels existing manifest review behavior.
