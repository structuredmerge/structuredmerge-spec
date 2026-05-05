# Slice 713: README Supplied Metadata Synchronization Acceptance

## Goal

Define provider-neutral native Markdown recipe behavior for synchronizing README
heading and summary content from caller-supplied metadata.

## Shared Behavior

This slice covers deterministic README metadata synchronization:

1. README metadata is supplied by wrapper-provided runtime context,
2. the native recipe replaces the document H1 with the supplied title,
3. the native recipe replaces or creates a configured summary section body,
4. unrelated README sections and surrounding prose are preserved,
5. native recipe execution fails closed with `configuration_error` when required
   metadata is missing or malformed,
6. gemspec parsing, package discovery, grapheme selection, URL construction, and
   deciding which sections to synchronize remain wrapper/plugin responsibilities.

## Notes

- This slice uses `provider_family: markdown` and a generic Markdown AST
  backend.
- The fixture models the README half of the old kettle-jem README/gemspec
  synchronization behavior without giving `ast-merge` gemspec or project
  awareness.
- The supplied metadata shape is a recipe contract, not a core project model.
