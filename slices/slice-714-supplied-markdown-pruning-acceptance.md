# Slice 714: Supplied Markdown Pruning Acceptance

## Goal

Define provider-neutral native Markdown recipe behavior for pruning Markdown
table rows and reference definitions from caller-supplied selectors.

## Shared Behavior

This slice covers deterministic Markdown pruning:

1. prune selectors are supplied by wrapper-provided runtime context,
2. the native recipe deletes matching Markdown table rows,
3. the native recipe deletes matching reference-link definitions,
4. unmatched rows, reference definitions, and surrounding prose are preserved,
5. native recipe execution fails closed with `configuration_error` when selectors
   are missing or malformed,
6. min-version policy, enabled-engine discovery, badge naming conventions, and
   deciding which selectors to prune remain wrapper/plugin responsibilities.

## Notes

- This slice uses `provider_family: markdown` and a generic Markdown AST
  backend.
- The fixture models the native substrate needed by README compatibility badge
  pruning without encoding Ruby engine/version semantics in `ast-merge`.
- The supplied selector shape is a recipe contract, not a core project model.
