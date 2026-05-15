# Slice 837: Kettle Jem Appraisal CLI Orchestration Helpers

## Goal

Port non-UI appraisal CLI orchestration behavior from old
`kettle-jem-appraisals` into active Ruby `kettle-jem`.

## Contract

Active `kettle-jem` exposes deterministic helpers for the behavior the old CLI
used before writing files or printing terminal output:

- extract runtime dependencies from a gemspec while ignoring commented lines;
- scaffold `.kettle-jem.yml` appraisal matrix config from runtime dependencies
  and x-stdlib exclusions;
- preserve configured tier2 matrix entries while replacing scaffolded tier1
  candidates;
- detect whether a matrix already contains resolved versions;
- enforce `resolved_at` plus `freshness_ttl` freshness checks;
- normalize include/exclude version lists after mode selection;
- expand all versions through the RubyGems resolver for patch and minor modes;
- check whether a tier2 version is compatible with a Ruby-series bucket.

The file-writing CLI shell remains a later integration layer. This slice keeps
the behavior available to recipe/report APIs first.
