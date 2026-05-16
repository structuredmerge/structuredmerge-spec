# Slice 840: Merge Approach Overview Alignment

## Goal

Align the old `ast-merge` merge-approach overview with the current
StructuredMerge fixture model.

## Contract

The old overview's core rule remains current: signatures identify candidate
matches, but they do not define output cardinality. Duplicate signatures must
be matched with ordered cursors or an equivalent 1:1 matching model.

The current portable wording is:

- matching is scoped by parent/container context;
- duplicate candidate signatures are consumed one match at a time;
- recursive body merges compare children only inside the matched parent;
- destination-only nodes remain destination-only unless an explicit removal
  policy applies;
- template-only nodes are inserted by an anchor-aware policy, not by a global
  append/prepend rule;
- per-format strategy notes are examples, not public architecture.

The old per-gem implementation notes are replaced by family/provider fixtures,
provider capability reports, and package-local implementation choices.
