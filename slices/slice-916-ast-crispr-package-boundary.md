# Slice 916: ast-crispr package boundary

## Purpose

`ast-crispr` is a thin, implementation-local structural edit tool package built
on top of the `ast-merge` structured-edit contracts.

This keeps `ast-merge` as the portable contract substrate while preserving a
separate package identity for ergonomic selectors, profiles, and operation
helpers inspired by the old Ruby `ast-crispr` family.

## Contract

- Each implementation ships an `ast-crispr` package.
- Each package depends on the local `ast-merge` package.
- The package does not fork or duplicate the `ast-merge` envelope vocabulary.
- Provider-specific behavior remains in provider packages unless a later slice
  deliberately introduces provider-specific `ast-crispr-*` extension packages.
- The initial package exposes a boundary report that identifies the shared
  ownership model and implementation package names.

## Fixture

- `fixtures/diagnostics/slice-916-ast-crispr-package-boundary/ast-crispr-package-boundary.json`

