# Slice 774: Kettle Jem Report Utilities

## Goal

Port the deterministic old `kettle-jem` report utilities that can live around
the active recipe-pack runner without resurrecting the old phase framework.

## Implemented

Ruby `kettle-jem` now exposes:

- `Kettle::Jem::TemplateChecksums` for template checksum computation, stored
  checksum loading, drift classification, summaries, detail lines, and
  `.kettle-jem.yml` checksum block updates;
- `Kettle::Jem::TemplatingReport` for merge-gem environment snapshots,
  console/Markdown environment rendering, local workspace warnings, run report
  paths, run report rendering, and report file writing;
- `Kettle::Jem::SelfTest::Manifest` for before/after file manifest generation
  and comparison;
- `Kettle::Jem::SelfTest::Reporter` for unified diffs and Markdown self-test
  summaries.

## Boundary

These utilities are diagnostic/report support for the current recipe-pack
runner. They do not reintroduce old phase objects, old setup/install/prepare
task APIs, or plugin lifecycle callbacks.

## Verification

`mise exec -C ruby -- bundle exec rspec gems/kettle-jem/spec/thin_slice_spec.rb`
passes with checksum drift and self-test/report coverage.
