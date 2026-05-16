# Slice 846: RSpec Shared Examples And Dependency Tag Inventory

## Goal

Classify the old Ruby `ast-merge` and `tree_haver` RSpec support against the
active StructuredMerge conformance harness.

## Contract

Portable behavior belongs in fixtures and conformance reports, not RSpec shared
examples.

Portable replacements:

- reproducible merge and partial-merge examples become manifest-addressable
  conformance cases with template, destination, expected output, idempotency,
  backend, and profile metadata;
- dependency tags become feature-profile requirements and backend/provider
  requirements in suite planning;
- skipped tests become explicit skipped conformance results with reason,
  requirement, active profile/backend, and summary counts;
- unresolved runtime shared examples become review-state, replay, execution,
  and transport fixtures;
- feature-profile shared examples become JSON fixture validation and typed
  profile contracts;
- comment/layout shared examples become comment, layout, render/reparse, and
  formatting-preservation fixtures.

Ruby-local helpers:

- test-only node builders may exist in Ruby packages when they reduce spec
  boilerplate;
- RSpec matchers or shared examples may wrap fixture assertions for Ruby
  maintainability;
- Ruby-local helpers must not define portable behavior that is absent from
  shared fixtures.

Retired behavior:

- merge-gem registry based dependency discovery is not portable API;
- positive/negative RSpec dependency tags are superseded by explicit
  conformance planning and skipped-result reports;
- old shared examples for retired base classes stay retired with their base
  classes.
