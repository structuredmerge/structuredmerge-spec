# Slice 849: Tree Haver Grammar Library Path Security Model

## Goal

Reconcile the old `tree_haver` grammar/library discovery security model with
the active StructuredMerge backend substrate.

## Contract

Active security checks:

- shared-library paths reject empty input, excessive length, null bytes,
  relative paths, parent/current-directory traversal, unsupported extensions,
  and unsafe filenames;
- versioned `.so.N` paths are accepted;
- language names, symbol names, and backend names are validated before use;
- backend names are valid only when they are `auto` or registered in the active
  backend registry;
- validators return stable error lists rather than one-off strings.

Retired or inactive old behavior:

- `TREE_SITTER_<LANG>_PATH` manual grammar overrides are not an active generic
  discovery path;
- `TREE_HAVER_TRUSTED_DIRS`, custom trusted directory mutation, and strict
  trusted-directory allowlisting are not active current behavior;
- manual shared-library grammar search is replaced for generic tree-sitter use
  by `tree-sitter-language-pack`;
- implementation-specific native providers may expose their own environment
  variables, but must project availability and rejection diagnostics through
  backend/provider reports.

Current environment vocabulary:

- `TREE_HAVER_BACKEND` selects a scoped backend context in Ruby tests and local
  execution;
- `KETTLE_DEV_DEBUG` may be used by workspace tooling for diagnostic verbosity;
- no generic active environment variable loads arbitrary grammar libraries.

Rule:

- any future reintroduction of manual grammar/library paths must add fixtures
  for trusted directories, explicit disablement, invalid explicit paths,
  diagnostic messages, and package-managed discovery precedence before code is
  exposed.
