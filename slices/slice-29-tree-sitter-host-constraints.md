# Slice 29: Tree-sitter Host Constraints

## Goal

Record cross-language host constraints that affect backend adoption.

## Planned Scope

- describe binding and runtime constraints that matter for tree-sitter adoption
- keep these constraints descriptive rather than normative merge semantics
- avoid hiding real platform limitations behind abstract backend vocabulary

## Notes

- This slice is planned ahead because backend adoption has already exposed a
  real host-specific TypeScript runtime constraint.
- In the current workspace environment, the official Node `tree-sitter` binding
  does not provide a native build for Node `22.22.2`, and the official
  `tree-sitter-json` npm package still advertises a peer dependency on
  `tree-sitter ^0.21.1`.
- That makes TypeScript backend adoption a host/runtime problem, not just an
  unimplemented wrapper.
- In the same environment, `@kreuzberg/tree-sitter-language-pack` does load and
  parse JSON successfully, so it is currently the most practical TypeScript
  backend candidate.
- In the same workspace, the published Rust crate
  `tree-sitter-language-pack` does load and parse JSON successfully, so it is a
  viable current backend candidate for the Rust implementation.
- The published Go module
  `github.com/kreuzberg-dev/tree-sitter-language-pack/packages/go` is not yet a
  practical backend candidate here. It raises the repo floor to Go `1.26`, and
  its published module payload does not include the `include/` and `lib/`
  artifacts referenced by its own CGO bindings, so downstream builds fail
  before runtime behavior can be evaluated.
