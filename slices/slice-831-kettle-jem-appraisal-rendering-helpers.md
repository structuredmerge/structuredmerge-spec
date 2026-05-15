# Slice 831: Kettle Jem Appraisal Rendering Helpers

## Goal

Port deterministic rendering helpers from `kettle-jem-appraisals` into active
Ruby `kettle-jem` before version resolution or matrix planning.

## Contract

Active `kettle-jem` exposes pure helpers for:

- appraisal gem-name abbreviation;
- appraisal-safe version formatting;
- generated appraisal names with the `kja` prefix;
- modular gemfile paths and content;
- generated `Appraisals` file content;
- workflow lifecycle grouping and YAML strategy snippets;
- extracted stdlib exclusion parsing from supplied template content.

These helpers must not perform network access or write files. Filesystem writes
remain a higher-level recipe/apply concern.

## Decision

Keep this behavior as Kettle/Jem recipe utility behavior. It is RubyGems and
appraisal2-specific, but deterministic enough to expose as a stable helper
surface for later recipe/report fixtures.
