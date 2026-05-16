# Slice 841: Ast Merge Base Class Inventory

## Goal

Classify the old Ruby `ast-merge` base-class stack against the active
StructuredMerge contracts before porting any class names or helpers.

## Contract

The active substrate does not restore the old base-class hierarchy as portable
API. The portable API is fixture suites, normalized tree/provider contracts,
matching reports, structured edit requests, execution reports, profile
promotion reports, and review/replay envelopes.

Classification:

- old `Runtime`, `Ruleset`, unresolved/review-state support: replaced by active
  structured execution, compact ruleset, profile, review-state, and replay
  fixtures;
- old `SmartMergerBase`, `ConflictResolverBase`, `FileAnalyzable`,
  `MergeResultBase`, `EmitterBase`, and `NodeWrapperBase`: not portable
  requirements; may be reintroduced only as Ruby adapter conveniences if a real
  Ruby package needs them;
- old `FreezeNodeBase`, `Freezable`, and `BlockDirective`: behavior belongs in
  freeze/comment fixtures and adapters, not as a copied base class first;
- old `MergerConfig`: replaced by explicit request/profile/policy fields;
- old `DebugLogger`: replaced by structured diagnostics and report artifacts;
- old RSpec support: replaced by fixture conformance, with Ruby-only helpers
  allowed locally when useful.
