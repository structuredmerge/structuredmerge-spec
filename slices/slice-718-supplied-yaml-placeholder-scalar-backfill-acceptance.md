# Slice 718: Supplied YAML Placeholder Scalar Backfill Acceptance

## Goal

Define provider-neutral native YAML recipe behavior for backfilling selected
placeholder or blank scalar values from caller-supplied runtime context.

## Shared Behavior

This slice covers deterministic YAML placeholder scalar backfill:

1. desired scalar values are supplied by wrapper-provided runtime context,
2. native recipe execution updates only matching scalar selectors whose current
   value is blank or placeholder-shaped,
3. existing concrete destination values are preserved,
4. comments and unrelated YAML content are preserved,
5. scalar quoting style is preserved when the selector contract requests it,
6. native recipe execution reports updated and preserved selector IDs, and
7. execution fails closed with `configuration_error` when required backfill
   context is missing or malformed.

## Notes

- This slice uses `provider_family: yaml` and a generic placeholder-backfill
  backend.
- The fixture models the native substrate needed by configuration token seeding
  without encoding `.kettle-jem.yml` project semantics in `ast-merge`.
- Wrappers/plugins own token discovery, environment lookup, placeholder syntax
  policy, and decisions about which scalar paths are safe to backfill.
