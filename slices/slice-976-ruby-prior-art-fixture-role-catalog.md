# Slice 976: Ruby Prior-Art Fixture Role Catalog

## Goal

Define the first fixture-role catalog for converting Ruby prior art from
`ast-merge` and `tree_haver` into portable StructuredMerge work.

## Contract

This slice defines a role catalog, not the final implementation of each role.

The catalog MUST group roles by contract layer:

- `tree_haver`
- `ast_merge`
- `source_family`
- `runtime_catchup`

Each role entry MUST include:

- a stable role name;
- a short description;
- the Ruby prior-art source;
- the intended portability level;
- the first convergence lane that should own implementation.

Ruby class names MAY appear as prior-art source labels, but they MUST NOT be
treated as portable API requirements.

## Fixture

`fixtures/diagnostics/slice-976-ruby-prior-art-fixture-role-catalog/ruby-prior-art-fixture-roles.json`

## Notes

- This slice follows the Ruby-first convergence decision: Ruby proves behavior
  first when its substrate is strongest, then Go, Rust, and TypeScript catch up
  against fixture roles.
- This catalog intentionally precedes broad manifest expansion. The next slices
  can promote selected roles into source-family manifests once the role names
  are stable.
