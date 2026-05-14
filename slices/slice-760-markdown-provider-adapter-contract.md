# Slice 760: Markdown Provider Adapter Contract

## Goal

Decide the common backend adapter contract for Markdown provider packages such
as `commonmarker-merge`, `markly-merge`, and `kramdown-merge`.

## Contract

Each Markdown provider package should:

- expose one provider package name;
- register one backend reference with `TreeHaver::BackendRegistry` or the
  language-equivalent backend registry;
- delegate `markdown_feature_profile` to the family package;
- expose only its own backend from `available_markdown_backends`;
- return a backend feature profile containing the family profile plus provider
  backend metadata;
- return a plan context containing the family profile and provider feature
  profile;
- parse Markdown through the provider parser and then project analysis through
  the family owner model;
- delegate owner matching to the family package;
- delegate section merge and reviewed nested merge operations to the family
  package;
- reject unsupported backend overrides with `unsupported_feature` diagnostics;
- conform to provider feature, plan, named-suite, manifest-report, and reviewed
  nested review artifact fixtures.

## Current Ruby Evidence

The active Ruby provider packages already follow this shape:

- `commonmarker-merge` registers backend `commonmarker`.
- `markly-merge` registers backend `markly`.
- `kramdown-merge` registers backend `kramdown`.

`markly-merge` also exposes structured-edit projections. Those projections are
provider-specific extensions and should remain fixture-backed instead of
becoming required of every Markdown provider.

## Decision

Use the provider adapter shape above as the shared contract. Provider packages
may expose parser-specific options and optional extension APIs, but the common
adapter contract is the fixture-backed family/provider surface.
