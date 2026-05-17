# Slice 841: Ast Merge Base Class Inventory

## Goal

Classify the old Ruby `ast-merge` base-class stack against the active
StructuredMerge contracts before porting any class names or helpers.

## Contract

The old Ruby base-class hierarchy is not a portable cross-language API, but it
does contain format-neutral Ruby provider substrate needed by active provider
gems. The portable API remains fixture suites, normalized tree/provider
contracts, matching reports, structured edit requests, execution reports,
profile promotion reports, and review/replay envelopes. Ruby provider packages
may depend on restored `ast-merge` helper classes when those helpers prevent
provider-local forks of merge orchestration, comments/layout handling, freeze
directives, debug provenance, result tracking, and partial-template behavior.

Classification:

- old `Runtime`, `Ruleset`, unresolved/review-state support: keep active
  structured execution, compact ruleset, profile, review-state, and replay
  contracts;
- old `SmartMergerBase`, `ConflictResolverBase`, `FileAnalyzable`,
  `MergeResultBase`, `EmitterBase`, `NodeWrapperBase`, partial-template helpers,
  match/refiner scaffolding, and debug helpers: restore as Ruby provider
  substrate in active `ast-merge` where format-neutral;
- old `FreezeNodeBase`, `Freezable`, and `BlockDirective`: restore shared Ruby
  helpers only behind freeze/comment directive fixtures and provider use;
- old `MergerConfig`: replaced by explicit request/profile/policy fields;
- old RSpec support: replaced by fixture conformance, with Ruby-only helpers
  allowed locally when useful.
