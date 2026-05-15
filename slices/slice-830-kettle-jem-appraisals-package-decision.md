# Slice 830: Kettle Jem Appraisals Package Decision

## Goal

Decide whether the old `kettle-jem-appraisals` package should remain a
separate active package, fold into active `kettle-jem`, or be replaced by
generated workflow fixtures.

## Old Package Value

The old package generated appraisal-driven CI matrices for Ruby gems:

- selected dependency versions from configured tier-1 and tier-2 gems;
- queried RubyGems version metadata and minimum Ruby floors;
- detected Ruby series buckets from dependency Ruby-version seams;
- resolved secondary dependency constraints;
- generated modular gemfiles and an `Appraisals` file;
- generated GitHub Actions matrix snippets grouped by lifecycle;
- excluded extracted standard-library gems that should stay in the base
  template;
- exposed a standalone CLI around this workflow.

## Decision

Do not keep `kettle-jem-appraisals` as a separate active package in this bridge
pass.

Fold the surviving value into active Ruby `kettle-jem` as fixture-backed
recipe/report behavior:

- deterministic matrix planning belongs in Kettle/Jem recipe utilities;
- generated `Appraisals`, modular gemfiles, and workflow matrix snippets belong
  in Kettle/Jem template/generation fixtures;
- RubyGems API access belongs behind an explicit resolver input boundary, so
  tests and HTTP envelopes can use supplied version metadata without network
  access;
- the CLI can be reintroduced later as a Kettle/Jem command wrapper over the
  same plan/apply/report APIs.

## Rationale

The old package was coupled to Kettle/Jem project conventions and appraisal2
workflow generation. It did not define a parser-neutral merge contract or a
language-independent structuredmerge surface. Keeping it separate would add a
second recipe runner and package boundary before the active Kettle/Jem API has
the fixture coverage needed by CLI, git integration, and HTTP envelopes.

## Porting Order

Port the old value in this order:

1. Pure naming and rendering helpers: gem abbreviations, appraisal names,
   modular gemfile paths, `Appraisals` rendering, and workflow matrix snippet
   rendering.
2. Deterministic matrix planning from supplied version metadata.
3. Ruby series seam detection and bucket assignment.
4. Secondary dependency resolution from supplied dependency metadata.
5. Optional RubyGems resolver adapter and stale-output cleanup.

Do not port the old executable name or package boundary as the public contract.
