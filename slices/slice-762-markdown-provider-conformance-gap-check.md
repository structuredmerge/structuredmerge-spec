# Slice 762: Markdown Provider Conformance Gap Check

## Goal

Check whether `commonmarker-merge`, `markly-merge`, `kramdown-merge`, and
other Markdown provider packages need additional conformance fixtures beyond
the generic Markdown family fixtures.

## Covered Provider Behavior

Current fixtures cover the common provider adapter contract:

- provider feature profiles;
- provider plan contexts;
- provider named-suite plans;
- provider manifest reports;
- provider parse/analysis/matching/merge conformance;
- unsupported provider backend override rejection;
- provider reviewed nested review artifact application;
- provider reviewed nested review artifact rejection;
- provider reviewed nested review artifact envelope application.

Current fixtures also cover a Markly-specific structured-edit provider
projection. That is a provider extension, not a requirement for every Markdown
provider.

## Remaining Provider-Specific Gaps

The following provider-specific values are not current generated README claims:

- Commonmarker parser option behavior.
- Markly flags and extension behavior.
- Kramdown parser option behavior.
- Pulldown CMark parser option behavior.
- markdown-it parser option/plugin behavior.
- Goldmark parser option behavior.
- Runtime/platform caveats for native parser dependencies beyond fixture-backed
  provider metadata.

## Decision

No additional provider conformance fixture is required for the current README
migration pass. Existing fixtures cover the shared adapter contract. Parser
options, plugin behavior, and runtime/platform caveats should be added later as
provider-specific fixture slices before they are documented as current behavior.
