# Slice 801: Kettle Jem Ruby Policy Fixtures

## Goal

Fixture the surviving old `kettle-jem` Gemfile, gemspec, and Appraisals policy
behavior before porting classifiers or dependency-policy helpers.

## Existing Fixture Coverage

The Ruby family already has parser-neutral fixtures for the core merge
semantics:

- `slice-700`: Gemfile declaration signature merge.
- `slice-702`: gemspec block signature merge.
- `slice-703`: gemspec field policy.
- `slice-704`: gemspec dependency section policy.
- `slice-705`: gemspec files policy.
- `slice-706`: gemspec version loader policy.
- `slice-708`: gemspec self-dependency policy.
- `slice-709`: Gemfile self-dependency policy.
- `slice-710`: Appraisals self-dependency policy.
- `slice-711`: Appraisals minimum-Ruby prune policy.

Those fixtures define portable Ruby behavior. Kettle/Jem should consume those
semantics through the Ruby merge layer where possible.

## Kettle/Jem Policy Fixtures

This slice adds a Kettle/Jem-level policy fixture for behavior that depends on
template application, package facts, or Kettle/Jem project conventions:

- Gemfile template application preserves destination-owned comment blocks,
  resolves template tokens before merge, removes self/conflicting dependency
  declarations, and adds missing template declarations without duplicating
  existing `eval_gemfile` lines.
- Gemspec template application preserves destination project metadata and
  dependency requirements while accepting generated template structure.
- Appraisals template application merges template appraisal blocks, removes
  active package self-dependencies, and prunes `ruby-X-Y` appraisals below the
  active minimum Ruby version.

## Implementation Status

The active Ruby `kettle-jem` runner already has partial coverage:

- Ruby-family template files route through `Kettle::Jem.merge_config_template_source`.
- Gemfiles use the Ruby merge layer for declaration convergence.
- Gemfile-like template output removes active package self-dependencies and old
  `appraisal` conflict declarations after merge.
- Gemspec templates preserve selected destination assignments and dependency
  lines.
- Gemspec preserved destination lines are normalized to the template block
  receiver when the destination uses a different `Gem::Specification` block
  parameter.
- Appraisals templates merge `appraise` blocks by name, preserve
  destination-only blocks, remove active package self-dependencies, and prune
  `ruby-X-Y` blocks below the gemspec minimum Ruby floor.
- Recipe step reports include `ruby_template_policy` metadata describing the
  policy operations applied for Gemfile, gemspec, and Appraisals template
  application.

## Porting Rule

Port helpers only when they satisfy these fixture cases or an existing
portable Ruby fixture. Do not reintroduce old helper class names as public API.
