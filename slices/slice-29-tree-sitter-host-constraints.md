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
