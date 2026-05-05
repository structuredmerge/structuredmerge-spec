# Slice 717: Supplied Managed Text Block Replacement Acceptance

## Goal

Define provider-neutral native text recipe behavior for replacing or appending
caller-supplied managed blocks bounded by sentinels.

## Shared Behavior

This slice covers deterministic managed text block replacement:

1. managed block updates are supplied by wrapper-provided runtime context,
2. native recipe execution finds blocks by exact open and close sentinels,
3. existing managed block spans are replaced in stable order,
4. missing managed blocks are appended when the update contract requests append
   fallback,
5. content outside managed blocks is preserved,
6. native recipe execution reports replaced and appended selector IDs, and
7. execution fails closed with `configuration_error` when required update
   context is missing or malformed.

## Notes

- This slice uses `provider_family: text` and a generic managed-block backend.
- The fixture models the native substrate needed by generated template regions
  such as shunted Gemfile dependency blocks without encoding RubyGems or Gemfile
  policy in `ast-merge`.
- Wrappers/plugins own generated content, sentinel conventions, dependency
  discovery, ordering policy, and decisions about whether missing blocks should
  be appended.
