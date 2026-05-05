# Slice 716: Supplied YAML Snippet Synchronization Acceptance

## Goal

Define provider-neutral native YAML recipe behavior for applying caller-supplied
section updates and scalar replacements.

## Shared Behavior

This slice covers deterministic YAML snippet synchronization:

1. YAML section updates are supplied by wrapper-provided runtime context,
2. scalar replacements are supplied by wrapper-provided selectors,
3. native recipe execution inserts or replaces exact key-path sections in stable
   order,
4. native recipe execution updates only matching caller-selected scalar values,
5. unrelated destination YAML, including nested job matrix content, is
   preserved,
6. native recipe execution reports applied section and scalar selector IDs, and
7. execution fails closed with `configuration_error` when required update
   context is missing or malformed.

## Notes

- This slice uses `provider_family: yaml` and a generic YAML snippet backend.
- The fixture models the native substrate needed by workflow snippet
  synchronization without encoding GitHub Actions policy in `ast-merge`.
- Wrappers/plugins own snippet discovery, workflow policy, action-pin policy,
  selector derivation, and decisions about which YAML paths or scalars should be
  synchronized.
