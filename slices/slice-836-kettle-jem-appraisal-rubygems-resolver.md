# Slice 836: Kettle Jem RubyGems Resolver

## Goal

Port RubyGems-backed version resolution from the old `kettle-jem` and
`kettle-jem-appraisals` packages into active Ruby `kettle-jem`.

## Contract

Active `kettle-jem` owns Ruby package ecosystem intelligence for Ruby project
templating. Gemfile, gemspec, and appraisal behavior can consume supplied
metadata for deterministic tests, but the package also exposes a cacheable
RubyGems resolver that can fetch the same metadata itself.

The resolver provides:

- stable and optional prerelease version listings from the RubyGems versions
  API;
- requirement filtering and minor-version grouping for matrix planning;
- per-version runtime dependency metadata from the RubyGems version API;
- minimum Ruby floor extraction from `required_ruby_version` constraints;
- in-memory response caching within a resolver instance.

Network access is not part of portable structured-merge behavior. It is
Kettle/Jem Ruby package ecosystem behavior, exercised through injected HTTP in
conformance fixtures and tests so the feature remains deterministic.

## Non-Goals

This slice does not create a generic cross-language metadata envelope and does
not move RubyGems resolution into `ast-merge`, `tree_haver`, HTTP envelopes, or
non-Ruby Kettle tools. Appraisal-specific code should depend on this core
resolver rather than owning a separate RubyGems client.
