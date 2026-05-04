# Slice 712: CHANGELOG Unreleased Normalization Acceptance

## Goal

Define provider-neutral native Markdown recipe behavior for normalizing a
CHANGELOG `Unreleased` section from caller-supplied entries.

## Shared Behavior

This slice covers deterministic CHANGELOG section normalization:

1. entries are supplied by wrapper-provided runtime context,
2. the native recipe locates a level-2 `Unreleased` heading when present,
3. when the heading is absent, the native recipe creates `## Unreleased` before
   the first release heading,
4. supplied entries are rendered as Markdown list items in deterministic order,
5. release-history sections and surrounding prose are preserved,
6. native recipe execution fails closed with `configuration_error` when entries
   are missing or malformed,
7. release policy, package discovery, and deciding which entries to include
   remain wrapper/plugin responsibilities.

## Notes

- This slice uses `provider_family: markdown` and a generic Markdown AST
  backend.
- The native recipe owns heading-section selection and deterministic Markdown
  rendering after inputs are supplied.
- The fixture intentionally does not encode Kettle-specific versioning or
  release conventions.
