# Slice 761: Markdown Provider Documentation Location

## Goal

Decide where backend-specific documentation for Markdown provider packages
should live.

## Decision

The `markdown-merge` family README should document portable Markdown behavior:

- family feature profile;
- supported fixture-backed owner analysis and matching;
- section merge;
- fenced-code discovery and nested merge;
- reviewed nested merge and review artifact behavior;
- a provider overview that points to provider packages.

Provider package READMEs should document backend-specific behavior:

- parser name and runtime dependency;
- backend id and provider package name;
- parser options and defaults;
- runtime/platform caveats;
- provider-specific extensions;
- provider-specific examples that are not cross-language family claims.

## Provider Examples

- `commonmarker-merge`: Commonmarker/Comrak parser dependency and options.
- `markly-merge`: Markly/libcmark-gfm dependency, flags, extensions, and
  structured-edit provider projections.
- `kramdown-merge`: Kramdown parser dependency and options.
- `pulldown-cmark-merge`: Rust Pulldown CMark provider behavior.
- `markdown-it-merge`: TypeScript markdown-it provider behavior.
- `goldmarkmerge`: Go Goldmark provider behavior.

## Generated README Policy

The shared generated family/backend section should include only the provider
overview. It should not copy parser-specific setup, options, or platform claims
into every package README.
