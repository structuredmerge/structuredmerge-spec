# Slice 266: Provider Registration Outside Portable Identity

## Goal

Keep parser/provider selection outside the canonical identity of a portable
suite descriptor.

## Contract

1. a portable suite descriptor MUST identify the grammar and required shared
   roles, not the provider package that will satisfy those roles
2. provider selection MUST remain outside portable suite identity even when
   more than one package can satisfy the same grammar
3. a tree-sitter-backed implementation MAY satisfy a grammar through the built
   in `tree-haver` / `tree_haver` backend registry
4. a non-tree-sitter provider package MAY also satisfy the same grammar by
   registering itself through that same backend registry surface
5. provider-specific feature profiles, plan contexts, named-suite plans, and
   manifest reports MAY mention provider/backend identity explicitly because
   those contracts describe execution context rather than portable suite
   identity

## Notes

- This keeps `markdown-it-merge`, `commonmarker-merge`, `markly-merge`,
  `kramdown-merge`, native tree-sitter Markdown, Prism, and other provider
  packages on the execution side of the boundary instead of the portable
  identity side.
