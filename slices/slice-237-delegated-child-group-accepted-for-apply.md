# Slice 237: Delegated Child Groups Accepted For Apply

`ast-merge` MUST provide a helper that selects projected child review groups
whose stable delegated-child review requests were accepted by replayed review
decisions.

The helper:

- MUST consider only review decisions for the delegated child apply action.
- MUST preserve group identity and order.
- MUST NOT accept incomplete or unrelated sibling groups unless their own
  delegated-child request identifiers were accepted.
