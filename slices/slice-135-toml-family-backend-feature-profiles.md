# Slice 135: TOML Family Backend Feature Profiles

## Goal

Expose the tree-sitter substrate backend profile for the TOML family.

## Shared Behavior

This slice defines one TOML family backend-profile contract:

1. the TOML family package exposes exactly one substrate backend profile,
2. that substrate profile keeps the shared TOML family identity while reporting
   tree-sitter backend capability details,
3. non-tree-sitter TOML backends belong in provider-package feature profiles,
   not in the substrate family package.

## Notes

- The first substrate backend is `kreuzberg-language-pack`.
- Native and PEG-backed TOML providers define their own feature profiles in
  provider-specific slices.
