# Slice 267: Portable Planning Uses Grammar Context

## Goal

Define the planning boundary between grammar-keyed portable suites and the
provider/backend contexts that execute them.

## Contract

1. portable suite planning MUST begin from the portable descriptor identity,
   including its `grammar`
2. planning MUST then resolve the execution context for that grammar from the
   host-supplied family or grammar context
3. the resolved execution context MAY carry backend/provider identity, feature
   profile, dialect support, and policy support
4. planning MUST preserve the portable suite descriptor unchanged while
   attaching the resolved execution context to planned runs
5. if no execution context is available for a grammar that requires one,
   planning MUST report that absence as a context-selection or configuration
   problem rather than mutating portable suite identity to guess a provider

## Notes

- The portable suite says "run the Markdown portable suite".
- The context says "use tree-haver tree-sitter Markdown" or "use
  markdown-it-merge" or "use kramdown-merge" for this host.
