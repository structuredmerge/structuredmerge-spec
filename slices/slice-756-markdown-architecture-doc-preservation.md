# Slice 756: Markdown Architecture Documentation Preservation

## Goal

Preserve the value from old `reference/markdown-merge/ARCHITECTURE.md` and
split generic Markdown family architecture from backend-specific adapter docs.

## Preserved Architecture Concepts

The current Markdown family should retain these old architecture concepts:

- layered package shape: family package plus parser/provider packages;
- node-by-node merge strategy for Markdown source preservation;
- top-level block analysis and owner matching;
- heading/section-oriented merge behavior;
- fenced-code embedded-family detection;
- delegated child operations for fenced code blocks;
- nested merge, reviewed nested merge, and review artifact application;
- source-preserving output assembly as an architectural goal;
- link reference parsing and rehydration as future source-preservation value;
- document-problem reporting for issues such as duplicate link definitions;
- backend/provider conformance through fixtures rather than Ruby-only runtime
  support tables.

## Current Fixture-Backed Claims

The current family already has fixture coverage for:

- Markdown feature profile, backend profiles, plans, named suites, and manifest
  reports;
- Markdown analysis for headings and code fences;
- path/equality owner matching;
- section merge;
- advanced nested section/list leaf merge;
- embedded fenced-code family detection;
- discovered fenced-code surfaces;
- delegated child operations;
- projected review groups, progress, ready groups, review transport, review
  state, and apply plans;
- delegated child apply output;
- nested merge and reviewed nested merge;
- reviewed nested review artifact application and rejection;
- provider reviewed nested review artifact application/rejection/envelope
  fixtures.

## Provider-Specific Docs

Provider-specific docs belong in the provider packages:

- Ruby `commonmarker-merge`, `markly-merge`, and `kramdown-merge`;
- Rust `pulldown-cmark-merge`;
- TypeScript `markdown-it-merge`;
- any future provider package.

Those docs may describe parser names, runtime constraints, backend defaults,
provider options, and provider-specific conformance. They should not replace
the `markdown-merge` family contract.

## Future Fixture Work

The following old architecture value remains useful but is not fully portable
README behavior yet:

- OutputBuilder as a source-preserving output assembly contract;
- link parser behavior for reference definitions, inline links, images, nested
  brackets, emoji labels, and UTF-8 positions;
- link reference rehydration from inline links back to reference links;
- link definition formatting;
- duplicate link definition/document-problem reporting;
- fuzzy table/list/code match refiners;
- cleanse passes;
- whitespace normalization policy.

## Decision

Preserve the old architecture as current migration guidance through this slice.
Do not copy the old Ruby class-level architecture docs into generated package
READMEs as-is. Use fixtures to expose the portable contract and provider
packages to document backend-specific behavior.
